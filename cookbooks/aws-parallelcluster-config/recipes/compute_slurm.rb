# frozen_string_literal: true

#
# Cookbook Name:: aws-parallelcluster
# Recipe:: compute_slurm
#
# Copyright 2013-2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the
# License. A copy of the License is located at
#
# http://aws.amazon.com/apache2.0/
#
# or in the "LICENSE.txt" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and
# limitations under the License.

setup_munge_compute_node

# Create directory configured as SlurmdSpoolDir
directory '/var/spool/slurmd' do
  user node['cluster']['slurm']['user']
  group node['cluster']['slurm']['group']
  mode '0700'
end

# Mount /opt/slurm over NFS
# Computemgtd config is under /opt/slurm/etc/pcluster; all compute nodes share a config
mount '/opt/slurm' do
  device(lazy { "#{node['cluster']['head_node_private_ip']}:/opt/slurm" })
  fstype "nfs"
  options node['cluster']['nfs']['hard_mount_options']
  action %i[mount enable]
  retries 10
  retry_delay 6
end

# Check to see if is GPU instance with Nvidia installed
Chef::Log.warn("GPU instance but no Nvidia drivers found") if graphic_instance? && !nvidia_installed?

cookbook_file '/etc/systemd/system/slurmd.service' do
  source 'compute_slurm/slurmd.service'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

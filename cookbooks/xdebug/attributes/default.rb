# 
# Cookbook Name:: xdebug
# Attributes:: default
#
# Author:: David King, xforty technologies <dking@xforty.com>
# Contributor:: Patrick Connolly <patrick@myplanetdigital.com>
#
# Copyright 2012, xforty technologies
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Pear search does not currently work with the preferred state. So we have to
# specify a default version for now.  https://pear.php.net/bugs/bug.php?id=19138
# TODO: implement preferred_state attribute and logic once pear bug is fixed

default[:xdebug][:version] = '2.1.3'

# XDEBUG.INI OPTIONS
default[:xdebug][:auto_trace]                = 0
default[:xdebug][:cli_color]                 = 0
default[:xdebug][:collect_assignments]       = 0
default[:xdebug][:collect_includes]          = 1
default[:xdebug][:collect_params]            = 0
default[:xdebug][:collect_return]            = 0
default[:xdebug][:collect_vars]              = 0
default[:xdebug][:coverage_enable]           = 1
default[:xdebug][:default_enable]            = 1
#default['xdebug']['dump.*']                 = Empty
default[:xdebug][:dump_globals]              = 1
default[:xdebug][:dump_undefined]            = 0
default[:xdebug][:extended_info]             = 1
default[:xdebug][:file_link_format]          = ''
#default[:xdebug][:idekey]                   = *complex*
default[:xdebug][:manual_url]                = 'http://www.php.net'
default[:xdebug][:max_nesting_level]         = 100
default[:xdebug][:overload_var_dump]         = 1
default[:xdebug][:profiler_append]           = 0
default[:xdebug][:profiler_enable]           = 0
default[:xdebug][:profiler_enable_trigger]   = 0
default[:xdebug][:profiler_output_dir]       = '/tmp'
default[:xdebug][:profiler_output_name]      = 'cachegrind.out.%p'
default[:xdebug][:remote_autostart]          = 0
default[:xdebug][:remote_connect_back]       = 0
default[:xdebug][:remote_cookie_expire_time] = 3600
default[:xdebug][:remote_enable]             = 0
default[:xdebug][:remote_handler]            = 'dbgp'
default[:xdebug][:remote_host]               = 'localhost'
default[:xdebug][:remote_log]                = ''
default[:xdebug][:remote_mode]               = 'req'
default[:xdebug][:remote_port]               = 9000
default[:xdebug][:scream]                    = 0
default[:xdebug][:show_exception_trace]      = 0
default[:xdebug][:show_local_vars]           = 0
default[:xdebug][:show_mem_delta]            = 0
default[:xdebug][:trace_enable_trigger]      = 0
default[:xdebug][:trace_format]              = 0
default[:xdebug][:trace_options]             = 0
default[:xdebug][:trace_output_dir]          = '/tmp'
default[:xdebug][:trace_output_name]         = 'trace.%c'
default[:xdebug][:var_display_max_children]  = 128
default[:xdebug][:var_display_max_data]      = 512
default[:xdebug][:var_display_max_depth]     = 3

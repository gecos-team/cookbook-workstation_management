# Groups list definition
default[:group_management][:administrator][:groups] = ['admin','adm']
default[:group_management][:administrator][:users_to_add] = []
default[:group_management][:administrator][:users_to_remove] = [] 
default[:group_management][:base][:groups] = ['dialout', 'fax', 'cdrom', 'floppy', 'tape', 'audio', 'dip', 'video', 'plugdev', 'fuse', 'sambashare']
default[:group_management][:base][:users_to_add] = []
default[:group_management][:base][:users_to_remove] = []

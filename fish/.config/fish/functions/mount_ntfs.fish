function mount_ntfs
  set name $argv[1]
  sudo mkdir /Volumes/$name
  sudo mount -t ntfs -o rw,auto,nobrowse /dev/$name /Volumes/$name
  open /Volumes/$name
end

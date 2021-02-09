variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable image_id {
  description = "Disk image"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key"
}
variable private_key {
  description = "private key"
}
variable count_app {
  description = "count instances"
  default     = 1
}
variable region_id {
  description = "region id"
  default     = "ru-central1"
}
variable docker_disk_image {
  description = "Disk image for docker"
  default     = "docker_disk_image"
}
variable access_key {
  description = "access_key infra-tf"
}
variable secret_key {
  description = "secret_key infra-tf"
}
variable bucket_name {
  description = "bucket_name"
}


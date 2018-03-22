update nf_media.ADMIN_CONFIG set admin_value = "/opt/data/media/" where admin_key="path_to_files";
update nf_media.ADMIN_CONFIG set admin_value = "beta-media.dina-web.net" where admin_key="mediaserver_host";
update nf_media.ADMIN_CONFIG set admin_value = "media" where admin_key="relative_new_stream_url";
#update media.ADMIN_CONFIG set admin_value = "media/v1" 			where admin_key="relative_new_stream_url";

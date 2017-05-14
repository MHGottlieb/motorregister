
# Downloader zip-arkiv med motorregisteret, ca. 2,8 GB, tager omtrent 24 minutter...

  time_start <- Sys.time()
  dir.create("data")
  file <- "ftp://dmr-ftp-user:dmrpassword@5.44.137.84/ESStatistikListeModtag/ESStatistikListeModtag-20170507-104738.zip"
  zip_file <- basename(file)
  download.file(file, file.path("data", zip_file))
  zip_size <- file.size(file.path("data", zip_file))
  time_end <- Sys.time() # download-tid 
  download_time <- time_end - time_start
  message(paste0("Hentet ", round(zip_size/10^9, 2), " Gb på ", 
                 round(download_time, 1), " minutter"))
  
# Udpakker zip-folder og læser data
  
  source("functions/decompress.R")
  time_start <- Sys.time()  
  decompress_file("data/", zip_file) # kalder OS-indbyggede unzip. Tager ca. 15. min.
  time_end <- Sys.time() # udpak-tid
  unpack_time <- time_end - time_start
  xml_file <- file.path("data", "ESStatistikListeModtag.xml")
  file_size <- file.size(xml_file)
  message(paste0("Udpakket ", round(zip_size/10^9, 2), " Gb til ", 
                 round(file_size/10^9, 2), " Gb på ",
                 round(unpack_time, 1), " minutter"))
  
# Indlæser xml-fil til R
  
  library(XML)
  time_start <- Sys.time()
  data <- xmlParse(xml_file)
  time_end <- Sys.time()
  print(time_end - time_start)
  

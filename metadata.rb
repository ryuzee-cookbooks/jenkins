name             "jenkins"
maintainer       "ryuzee"
maintainer_email "ryuzee@gmail.com"
license          "MIT"
description      "Installs/Configures jenkins"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"
depends          "yum", ">= 3.0"
depends          "yum-epel"
depends          "apt"
depends          "ca-certificates"
depends          "apache2-simple"


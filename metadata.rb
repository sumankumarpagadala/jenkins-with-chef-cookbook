name 'apache9'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures apache9'
long_description 'Installs/Configures apache9'
version '1.3.0'
chef_version '>= 13.0'

# The `issues_url` points to the locatioclsn where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/apache9/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/apache9'

# this cookbook with jenkins http://ftp-chi.osuosl.org/pub/jenkins/war/2.156/jenkins.war
depends 'tar', '~> 2.2.0'
depends 'firewall', '= 2.6.5'

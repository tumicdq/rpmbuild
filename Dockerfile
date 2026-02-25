# Using almalinux:latest as base image for this container
FROM opensuse/tumbleweed

# Copying all contents of rpmbuild repo inside container
COPY . .

# Installing tools needed for rpmbuild ,
# depends on BuildRequires field in specfile, (TODO: take as input & install)
RUN zypper install -y rpm-build rpmdevtools gcc make python3 git nodejs npm

# Install dependecies and build main.js
RUN npm install --production \
&& npm run-script build

# All remaining logic goes inside main.js ,
# where we have access to both tools of this container and
# contents of git repo at /github/workspace
ENTRYPOINT ["node", "/lib/main.js"]

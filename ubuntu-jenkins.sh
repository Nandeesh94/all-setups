#!/bin/bash

echo "➡️  Updating system and installing base packages..."
sudo apt update -y
sudo apt install -y git wget unzip curl

echo "✅ Git installed."
git --version

echo "➡️  Installing Java 1.8 and Java 17..."
sudo apt install -y openjdk-8-jdk openjdk-17-jdk

echo "✅ Java versions:"
java -version
update-alternatives --config java

echo "➡️  Installing Maven 3.9.9..."
cd /tmp
wget https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar -xvzf apache-maven-3.9.9-bin.tar.gz -C /opt/
sudo ln -sf /opt/apache-maven-3.9.9/bin/mvn /usr/bin/mvn

echo "✅ Maven version:"
mvn -version

echo "➡️  Downloading Jenkins Debian package (manual install for Ubuntu 24.04)..."
wget https://pkg.jenkins.io/debian-stable/binary/jenkins_2.440.1_all.deb

echo "➡️  Installing Jenkins..."
sudo apt install -y fontconfig
sudo dpkg -i jenkins_2.440.1_all.deb || sudo apt --fix-broken install -y

echo "✅ Enabling and starting Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "✅ Jenkins status:"
sudo systemctl status jenkins | grep Active

echo "🔑 Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

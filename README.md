# LimeSurvey-OCP

This is to use [LimeSurvey](https://www.limesurvey.org) Community Edition on any OpenShift Platform (OCP).  The `limesurvey.yaml` script utilises the [BuildConfig](https://docs.openshift.com/container-platform/4.10/cicd/builds/understanding-buildconfigs.html) capabilities of OCP to pull down certain Docker containers and build the LimeSurvey image based on the Dockerfile and other files in the repository.

What does it do?
1. Create a namespace/project called `limesurvey`
2. Creates an ImageStream of MySQL from the Docker Hub MySQL v5.7
3. Creates an ImageStream of Apache HTTPD with PHP v8
4. Creates an ImageStream based on the Apaache HTTPD with PHP, grabs the content of this repository, builds an image with LimeSurvey installed and configured
5. Creates a PersistentVolumeClaim for persisting MySQL data
6. Creates a Secret with MySQL and LimeSurvey users and passwords
7. Creates a Deployment for MySQL
8. Creates a service for MySQL
9. Create a Deployment for LimeSurvey
10. Creates a service for LimeSurvey
11. Creates an external Route for LimeSurvey to be accessed

The Secret can be updated with the appropriate userid/password for LimeSurvey and passwords for MySQL access.  They must be in Base64 format.</br>
`root-password`: MySQL root password (default: password)</br>
`mysql-password`: Password for LimeSurvey (default user: limesurvey, default password: password)</br>
`admin-user`: user for LimeSurvey interface (default: admin)</br>
`admin-password`: user password for LimeSurvey (default: password)</br>
`admin-email`: email address of the amdmin user (default admin@admin.com)</br>

In addition, the PVC should have the correct `storageClassName` for the platform.

The current version of LimeSurvey is 5.3.10+220419 (as of 29/04/2022).  This can be updated in the `Dockerfile` by looking at the release [URL](https://github.com/LimeSurvey/LimeSurvey/tags) and updating the `version` value in the file.

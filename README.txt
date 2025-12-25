This document provides a quick overview of the Sample Python Project.


This project implements and tests basic arithmetic functions in Python.
Function	Description
add		Performs addition.
subtract	Performs subtraction.
multiply	Performs multiplication.
division	Performs division.

After a successful build (e.g., in a CI environment like Jenkins), two primary artifacts are generated:
Artifact	Purpose
Package	The deployable component containing the implemented math functions.
Test Reports	Detailed results of the unit tests, typically in JUnit XML format, confirming function correctness.


The following Groovy scripts can be executed in the Jenkins Script Console (→ Manage Jenkins) to manage job build history.

Use this to clear the build history for one named job and reset its build counter to 1.

def jobName = "your_job_name_here" // Change this to your job's name
def job = Jenkins.instance.getItem(jobName)
job.getBuilds().each { it.delete() }
job.nextBuildNumber = 1 // Optional: Reset the next build number to 1
job.save()


⚠️ CAUTION: This deletes the entire build history across all jobs on the Jenkins instance.

import hudson.model.Job
Jenkins.instance.getAllItems(Job.class).each { job ->
    println("Deleting all builds for job: " + job.fullName)
    job.getBuilds().each { build ->
        build.delete()
    }
    job.nextBuildNumber = 1 // Optional: Reset the next build number to 1
    job.save()
}


asdasfasdf
asdfasdfadsf

pipeline {
    agent {
        label "xcloud"
    }
    environment {
        FASTLANE_USER = credentials('ios_fastlane_user')
        FASTLANE_PASSWORD = credentials('ios_fastlane_password')
        MATCH_PASSWORD = credentials('ios_match_password')
        LC_CTYPE = 'en_US.UTF-8'
        PATH = '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
    }
    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }

    stages {
        stage("Prepare environment") {
            steps {
                checkout scm

                script {
                    sh '''#!/bin/bash -l
                        rvm use
                        bundle install
                        echo "XCode version:"
                        xcodebuild -version
                        echo "OSX version:"
                        defaults read loginwindow SystemVersionStampAsString
                    '''
                }
            }
        }
        stage("Build") {
            steps {
                checkout scm

                script {
                    sh '''#!/bin/bash -l
                        bundle exec fastlane tests
                    '''
                }
            }
        }
    }

    post {
        always {
            junit 'fastlane/test_output/report.junit'
            junit 'fastlane/test_output/report_unit.junit'
            archiveArtifacts artifacts: 'fastlane/test_output/report.xcresult.zip', fingerprint: true
        }
    }
}

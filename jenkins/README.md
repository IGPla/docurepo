# Jenkins

## Installation

It just need Java JDK. 

Install Jenkings by downloading jenkins war 

```
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
```

and start it

```
java -jar jenkins.war --httpPort=8090
```

## Usage

Jenkins can be configured on project basis. Each project should have in its root folder a file called Jenkinsfile. This file contains the definition of a Pipeline.

To be able to use Jenkinsfile, you must create a pipeline first. It is done by clicking "New item" in jenkins interface, select a "Multibranch Pipeline", click on "Add source" button, type the repository url and credentials and save it. 

The previous steps must be performed for every single project.

### Pipeline structure

A pipeline is defined by "pipeline" keyword

```
pipeline {

}
```

#### Sections

- agent: specifies where stage or entire Pipeline will execute in the Jenkins environment
  - any: execute on any available agent
  - none: no one will be executed
  - label: execute the pipeline or stage on an agent available in the Jenkins environment with the provided label
  - docker: execute the pipeline or stage with the given container which will be dynamically provisioned on a node preconfigured to accept Docker-based pipelines.
  - dockerfile: execute the pipeline or stage with a container build from a Dockerfile contained in the source repository
Example

```
pipeline {
	agent {
		docker {
			image 'mydockerimage:version'
			label 'agent-label'
			args '-v /tmp:/tmp'
		}
	}
}
```

- post: define actions which will be run at the end of the pipeline or stage

Example

```
pipeline {
	agent any
	stages {
		...
	}
	post {
		always {
			echo "Finished"
		}
	}
}
```

- stages: contains a sequence of one or more stage directives

Example

```
pipeline {
	agent any
	stages {
		stage('S1'){
			steps {
				echo "Step 1"
			}
		}
	}
}
```

- steps: this section defines a series of one or more steps to be executed in a given stage
- tools: tools that must be installed and added to PATH. Supported tools are maven, jdk and gradle

#### Directives

- environment: specifies a sequence of key-value pairs which will be defined as environment variables for all steps

Example

```
pipeline {
	agent any
	environemnt {
		CC = 'myval'
	}
	stages {
		stage('s1'){
			environment {
				CV = 'myval2'
			}
			steps {
				...
			}
		}
	}
}
```

- options: allowws configuring specific options, like timeout, retry...
- parameters: provides a list of parameters which a user should fill. The values are made available via the params object.

Example

```
pipeline {
	agent any
	parameters {
		string(name: 'APARAM', description: 'Description of APARAM', defaultValue: 'A VAL')
	}
	stages {
		stage(s1) {
			stage {
				echo "This is ${params.APARAM}
			}
		}
	}
}
```

- triggers: defines automated ways in which the Pipeline should be re-triggered. Opions are cron (cron-like string defining a recurrent operation), pollSCM and upstream.

- stage: contains a steps section with all steps inside
- when: defines whether the stage shoud be executed depending on the given condition. Available conditions are branch, environment, expression, not, allOf, and anyOf

Example

```
pipeline {
	agent any
	stages {
		stage('s1') {
			steps {
				echo '1'
			}
		}
		stage('s2') {
			when {
				branch 'abranchname'
			}
			steps {
				echo '2'
			}
		}
	}
}
```

- paralel: it is used instead of steps. It declares several stage that must be ran in paralel

Example

```
pipeline {
    agent any
    stages {
        stage('Non-Parallel Stage') {
            steps {
                echo 'This stage will be executed first.'
            }
        }
        stage('Parallel Stage') {
            when {
                branch 'master'
            }
            failFast true
            parallel {
                stage('Branch A') {
                    agent {
                        label "for-branch-a"
                    }
                    steps {
                        echo "On Branch A"
                    }
                }
                stage('Branch B') {
                    agent {
                        label "for-branch-b"
                    }
                    steps {
                        echo "On Branch B"
                    }
                }
            }
        }
    }
}
```

#### Steps

Steps provide the last point where some work must be done. There're a lot of steps predefined with plugins. In the following URL they can be found

https://jenkins.io/doc/pipeline/steps/


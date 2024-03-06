# quarkus-graalvm-aws-lambda-arm64
Skeleton for a Quarkus app that exposes as REST endpoint, compiles as a GraalVM native image on arm64 architecture, deploys to AWS Lambda and exposes the REST endpoint via AWS API gateway.  
You can build & test the app locally (on an arm64 machine such as a Macbook M1 or M2) like a regular Quarkus/REST application, and the included tooling automatically builds and deploys this to AWS lambda.
Since both development and production runs on arm64, no cross compiling or emulation is necessary making the whole process relatively fast.
  
This skeleton is based on the NLJUG events app backend.

## Getting started
Prerequisites:
- An ARM machine (Macbook M1/M2 for example) 
- Java 17
- Maven
- An AWS account 
- AWS CLI installed (see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- AWS SAM CLI installed (see https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- Configured AWS CLI (via `aws configure`) - access & secret key configured for your AWS account

## Howto
This skeleton is based on the following guide: https://quarkus.io/guides/aws-lambda-http - kudos to the Quarkus team for writing it!

## Generation
This skeleton was generated using the `quarkus-amazon-lambda-rest-archetype`:

```
mvn archetype:generate \
       -DarchetypeGroupId=io.quarkus \
       -DarchetypeArtifactId=quarkus-amazon-lambda-rest-archetype \
       -DarchetypeVersion=3.8.1
```


## Development / local testing
Start a local application using the Quarkus dev mode with `mvn quarkus:dev`.
The app will start running on `http://localhost:8080` and you can build/test it like a regular REST endpoint.

## Build & native image generation
`scripts/build.sh` (or `mvn package -Dnative -Dquarkus.native.container-build=true`)

Note: if you want to build and deploy on another architecture than arm64, edit `config/sam.native.yaml`:
- change architecture (under "Architectures" to `arm64`)
- change `Runtime` to `provided`
- 
Building the native image on a M1 Macbook Pro takes just over a minute. 

## Running the native image locally for testing purposes
Running the lambda:
`scripts/run-local.sh` (or `sam local start-api --template target/sam.native.yaml`)

Testing the lambda:
`curl localhost:3000/hello`
should output:
`Hi from NLJUG!`

## Lambda deployment configuration
Edit `target/sam.native.yaml` to suit your needs, for example tweak the `MemorySize`

## Deploying
`scripts/deploy.sh` (or `sam deploy -t target/sam.native.yaml -g`)

Go with the default values:
```
	Setting default arguments for 'sam deploy'
	=========================================
	Stack Name [sam-app]: 
	AWS Region [eu-west-1]: 
	#Shows you resources changes to be deployed and require a 'Y' to initiate deploy
	Confirm changes before deploy [y/N]: y
	#SAM needs permission to be able to create roles to connect to the resources in your template
	Allow SAM CLI IAM role creation [Y/n]: y
	#Preserves the state of previously provisioned resources when an operation fails
	Disable rollback [y/N]: n
	QuarkusGraalvmAwsLambdaNative may not have authorization defined, Is this okay? [y/N]: y
	Save arguments to configuration file [Y/n]: y
	SAM configuration file [samconfig.toml]: 
	SAM configuration environment [default]: 
```

Note: the stack that will be deployed will be named `sam-app` if you go for the defaults offered by `sam`.  
If you already have a lambda deployed with name `sam-app`, it will be replaced by this lambda! Update the name accordingly if you don't want to overwrite an existing `sam-app`.

The `sam deploy` command will return the URL of the deployed lambda+API gateway.

## Testing the production deployment
Use the URL from the `sam deploy` command output.
Test the lambda via `curl <url>/hello`

This should output `Hi from NLJUG!`.

## Deleting the lambda + API gateway
`scripts/destroy.sh` (or `sam delete`)
This will delete the lambda, API gateway and any associated resources. 

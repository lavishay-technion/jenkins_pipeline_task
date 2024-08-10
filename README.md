# jenkins_task

## Main pipeline
One main pipeline, that runs seperate pipelines on the workers. 
The main pipeline is triggered by Curl command:

curl -u admin:admin localhost/job/pipeline_00_manager/build?token=manager_token

## Sub pipelines
All sub pipelines are triggered by using "build job"(We coudn't find a way to get the info from the jobs by using curl command). 
Every sub pipeline can be triggered by a curl command as well, writted in comment in the relevant section. 
All pipelines generate a report, that is saved using a volume with all of the containers in ./reports
All pipelines are using installation scripts(Prerequsitions for every pipeline). pipeline 1-3 uses execution scripts, and pipeline 4 executes on the jenkins file. 

### Short explanation on the sub pipelines:
- The first pipeline runs "Hunspell" for spell checking files
- The second pipeline runs Codeshell and shellcheck
- The third runs pytest to test the application's main python codes
- the forth builds the image and pushes it to dockerhub: https://hub.docker.com/repository/docker/orinahum1982/details_app_pipeline/general


## Notes:
- Jenkins entire setup data is volumed into docker/conf_files, so it saves all jenkins configuration when you run the containers. 
- Docker compose up from docker folder, curl to activate main pipeline, and everything will work accordingly. 
- Application's GIT in: https://github.com/orinahum/Details_App.git It containes modifications for the pytest section

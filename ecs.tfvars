region = "ap-south-1"
deploy_user = "personal"
environments = "wego"
ecr_repo_name = "fortune-api"
template_file_name = "app.json.tpl"
repo_url = "890901581284.dkr.ecr.ap-south-1.amazonaws.com/fortune-api"
ecsRole = "arn:aws:iam::890901581284:role/ecsTaskExecutionRole"
taskRole = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
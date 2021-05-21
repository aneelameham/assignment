data "template_file" "wegoapp" {
  template = file(var.template_file_name)
  vars = {
    aws_ecr_repository = var.repo_url
    app_port           = 80
  }
}

resource "aws_ecs_task_definition" "service" {
  family                   = "app-${var.environments}"
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecsRole
  cpu                      = 256
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.wegoapp.rendered
}

resource "aws_ecs_cluster" "wego" {
  name = "${var.environments}-ecs-cluster"
}

resource "aws_ecs_service" "wego" {
  name            = "wegoapp"
  cluster         = aws_ecs_cluster.wego.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnet_ids.default.ids
    assign_public_ip = true
  }
  
  load_balancer {
    target_group_arn = aws_lb_target_group.wego.arn
    container_name   = "pythonapi"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.https_forward, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
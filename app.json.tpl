[
  {
    "name": "pythonapi",
    "image": "${aws_ecr_repository}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080,
        "protocol": "tcp"
      }
    ],
    "cpu": 1,
    "ulimits": [
      {
        "name": "nofile",
        "softLimit": 65536,
        "hardLimit": 65536
      }
    ],
    "mountPoints": [],
    "memory": 2048,
    "volumesFrom": []
  }
]
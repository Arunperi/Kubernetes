aws_region = "us-east-1"

cluster_role_name = "eksClusterRole"

cluster_assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

cluster_manages_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
]
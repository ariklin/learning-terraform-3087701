module "explore-california-cluster" {
  source          = "../modules/cluster"
  cluster_name    = "explore-california-cluster"
  cluster_version = "1.20"
  subnets          = module.explore-california-vpc.public_subnets
  vpc_id          = module.explore-california-vpc.vpc_id
  worker_groups = [
    {
      instance_type = "t3.medium"
      asg_max_size  = 5
      spot_price = "0.02"
      additional_security_group_ids = [ aws_security_group.enable_ssh.id ]
      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
      suspended_processes = ["AZRebalance"]
    },
    {
      instance_type = "t3.large"
      asg_max_size  = 5
      spot_price = "0.03"
      additional_security_group_ids = [ aws_security_group.enable_ssh.id ]
      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
      suspended_processes = ["AZRebalance"]
    }
  ]
}
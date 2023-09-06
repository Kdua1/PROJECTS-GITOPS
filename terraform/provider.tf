terraform {
  backend "s3" {
    bucket = "fusion1-state-tf"
    key    = "fusion1 state-tf"
    region = "us-east-1"
  }
}


export KOPS_STATE_STORE="fusion1-state-tf"
export NODE_SIZE="m5.large"
export ZONES="us-east-1a,us-east-1b,us-east-1c"
kops create cluster kds.com \
--node-count 3 \
--zones $zones \
--node-size $NODE_SIZE \
--control-plane-size $CONTROL_PLANE_SIZE \
--control-plane-size $ZONES
--networking-cilium \
--topology private \
--cloud=aws \
--bastian="true"
--out=./terraform.main.tf \
--target=terraform
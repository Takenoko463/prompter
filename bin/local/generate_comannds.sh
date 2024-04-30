#!/bin/bash
{
  message="AWSへのSSH接続を行えます。"
  KEY_PAIR_FILE_PATH="~/.ssh/my-key-pair.pem"
  EIP="54.199.100.28"
  SSH_TO_AWS="ssh -i ${KEY_PAIR_FILE_PATH} ec2-user@${EIP}"
  echo "$message "\
  "$SSH_TO_AWS" 
}

{
  message="AWSへのdeployを実行できます。"
  echo $message\
  "bundle exec cap production deploy"
}
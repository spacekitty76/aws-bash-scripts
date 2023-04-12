#!/bin/bash 

### NOTE: Need to move this into a folder where I can auth using our Okta flow. Run it from in there.
### NOTE: Need to install jq tool. On mac, it's `brew install jq`
### NOTE: Don't forget OAR crossAccountAdmin or whatever account.

regions=("us-east-1" "us-east-2" "us-west-1" "us-west-2")

for region in ${regions[@]}
do
    echo "Checking region: $region"
    aws acm list-certificates --certificate-statuses "ISSUED" --region $region --color on >> certs.json
    cert_arns=$(jq '.CertificateSummaryList[].CertificateArn' certs.json)
done


cert_arns=$(jq '.CertificateSummaryList[].CertificateArn' certs.json)
echo "Cert arns: $cert_arns" > cert-arns.txt

# for cert in ${cert_arns[@]}
# do
#     echo "a cert: $cert"
#     aws acm delete-certificate --region $region --certificate-arn $cert
# done

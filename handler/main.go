package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/route53"
)

type myEvent struct {
	RequestParameters struct {
		HostedZoneID string `json:"hostedZoneId"`
		VPC          struct {
			Region string `json:"vPCRegion"`
			ID     string `json:"vPCId"`
		} `json:"vPC"`
	} `json:"requestParameters"`
}

func handler(ctx context.Context, event myEvent) {
	// Assoiciate VPC
	sess, err := session.NewSession()
	if err != nil {
		fmt.Printf("error creating session: %v", err)
		return
	}

	svc := route53.New(sess)
	input := route53.AssociateVPCWithHostedZoneInput{
		HostedZoneId: aws.String(event.RequestParameters.HostedZoneID),
		VPC: &route53.VPC{
			VPCId:     aws.String(event.RequestParameters.VPC.ID),
			VPCRegion: aws.String(event.RequestParameters.VPC.Region),
		},
	}

	resp, err := svc.AssociateVPCWithHostedZone(&input)
	if err != nil {
		fmt.Printf("error associating VPC with hosted zone: %v", err)
	}

	fmt.Printf("Response: %v", resp)
}

func main() {
	lambda.Start(handler)
}

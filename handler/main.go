package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
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

func handler(ctx context.Context, e events.CloudWatchEvent) {
	fmt.Printf("Event: %v\n", e)

	var event myEvent

	err := json.Unmarshal(e.Detail, &event)
	if err != nil {
		fmt.Printf("error unmarshaling event: %v\n", err)
	}

	fmt.Printf("Details: %v", event)

	// Assoiciate VPC
	sess, err := session.NewSession()
	if err != nil {
		fmt.Printf("error creating session: %v\n", err)
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
		fmt.Printf("error associating VPC with hosted zone: %v\n", err)
	}

	fmt.Printf("Response: %v\n", resp)
}

func main() {
	lambda.Start(handler)
}

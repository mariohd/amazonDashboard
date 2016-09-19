package br.unifor.ppgia.awsda;

import javax.enterprise.inject.Any;
import javax.enterprise.inject.Produces;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.EnvironmentVariableCredentialsProvider;
import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.model.Region;

@Any
public class AmazonEC2Factories {

	@Produces
	public AWSCredentials credentials() {
		return new EnvironmentVariableCredentialsProvider().getCredentials();
	}

	@Produces
	public AmazonEC2Client client(AWSCredentials credentials, Region selectedRegion) {
		AmazonEC2Client ec2 = new AmazonEC2Client(credentials);
		ec2.setEndpoint(selectedRegion.getEndpoint());
		return ec2;
	}

	@Produces
	public Region selectedRegion(SessionHolder session) {
		return session.selectedRegion();
	}
}

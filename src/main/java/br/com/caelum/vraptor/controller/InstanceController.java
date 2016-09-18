package br.com.caelum.vraptor.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Result;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.ec2.AmazonEC2;
import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.model.CreateTagsRequest;
import com.amazonaws.services.ec2.model.DescribeImagesRequest;
import com.amazonaws.services.ec2.model.DescribeImagesResult;
import com.amazonaws.services.ec2.model.DescribeInstancesResult;
import com.amazonaws.services.ec2.model.DescribeRegionsResult;
import com.amazonaws.services.ec2.model.Filter;
import com.amazonaws.services.ec2.model.Instance;
import com.amazonaws.services.ec2.model.Reservation;
import com.amazonaws.services.ec2.model.RunInstancesRequest;
import com.amazonaws.services.ec2.model.RunInstancesResult;
import com.amazonaws.services.ec2.model.Tag;

@Controller
@Path("instances")
public class InstanceController {
	private final Result result;
	
	/**
	 * @deprecated CDI eyes only
	 */
	protected InstanceController() {
		this(null);
	}
	
	@Inject
	public InstanceController(Result result) {
		this.result = result;
	}
	
	@Path("/")
	public void index() {
		result.redirectTo(this).list();
	}
	
	@Path("create")
	public void createInstance(String regionEndpoint, String instanceName, String instanceDescription, String amiID) {
		AWSCredentials credentials = new ProfileCredentialsProvider("default").getCredentials();
        AmazonEC2 ec2 = new AmazonEC2Client(credentials);
        
        ec2.setEndpoint(regionEndpoint);
        
    	RunInstancesRequest runInstancesRequest = new RunInstancesRequest();
    		        	
    	runInstancesRequest.withImageId(amiID)
	                     .withInstanceType("t2.micro")
	                     .withMinCount(1)
	                     .withMaxCount(1)
	                     .withKeyName("myFirstKeyPair")
	                     .withSecurityGroups(new ArrayList<String>());

    	RunInstancesResult runInstances = ec2.runInstances(runInstancesRequest);

    	
    	List<Instance> instances = runInstances.getReservation().getInstances();
    	for (Instance instance : instances) {
    	  CreateTagsRequest createTagsRequest = new CreateTagsRequest();
    	  createTagsRequest
    	  	.withResources(instance.getInstanceId())
    	  	.withTags(new Tag("Name", instanceName), new Tag("Description", instanceDescription));
    	  ec2.createTags(createTagsRequest);
    	}
    	
    	result.redirectTo(this).list();
	}
	
	@Path("add/region")
	public void region() {
		AWSCredentials credentials = new ProfileCredentialsProvider("default").getCredentials();
        AmazonEC2 ec2 = new AmazonEC2Client(credentials);
        
        DescribeRegionsResult describeRegions = ec2.describeRegions();
        
        result.include("regions", describeRegions.getRegions());
	}
	
	@Post("add/ami")
	public void ami(String regionEndpoint) {
		AWSCredentials credentials = new ProfileCredentialsProvider("default").getCredentials();
        AmazonEC2 ec2 = new AmazonEC2Client(credentials);
        ec2.setEndpoint(regionEndpoint);
        
        DescribeImagesRequest dir = new DescribeImagesRequest();
     
        Filter f = new Filter("root-device-type", Arrays.asList("ebs"));
        Filter f2 = new Filter("block-device-mapping.volume-type", Arrays.asList("gp2"));
        Filter f3 = new Filter("image-type", Arrays.asList("machine"));
        Filter f4 = new Filter("owner-alias", Arrays.asList("amazon"));    
        Filter f5 = new Filter("state", Arrays.asList("available"));
        Filter f6 = new Filter("virtualization-type", Arrays.asList("hvm"));
      
        dir.setFilters(Arrays.asList(f, f2, f3, f4, f5, f6));
        
        DescribeImagesResult describeImages = ec2.describeImages(dir);
        
        result.include("regionEndpoint", regionEndpoint);
        result.include("images", describeImages.getImages().subList(0, 200));
	}
	
	@Path("/list")
	public void list() {
		AWSCredentials credentials = new ProfileCredentialsProvider("default").getCredentials();

        AmazonEC2 ec2 = new AmazonEC2Client(credentials);
        ec2.setEndpoint("ec2.us-west-2.amazonaws.com");
        
		DescribeInstancesResult results = ec2.describeInstances();
		List<Reservation> reservations = results.getReservations();
		List<Instance> ins = new ArrayList<Instance>();

		for (Reservation reservation : reservations) {
		    ins.addAll(reservation.getInstances());
		}
		
		result.include("instances", ins);
		result.include("regionEndpoint", "ec2.us-west-2.amazonaws.com");
	}


}

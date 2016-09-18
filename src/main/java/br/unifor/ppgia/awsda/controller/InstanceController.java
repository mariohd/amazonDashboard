package br.unifor.ppgia.awsda.controller;

import static java.util.Arrays.asList;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.model.CreateTagsRequest;
import com.amazonaws.services.ec2.model.DescribeImagesRequest;
import com.amazonaws.services.ec2.model.DescribeImagesResult;
import com.amazonaws.services.ec2.model.DescribeInstancesResult;
import com.amazonaws.services.ec2.model.Filter;
import com.amazonaws.services.ec2.model.Instance;
import com.amazonaws.services.ec2.model.Reservation;
import com.amazonaws.services.ec2.model.RunInstancesRequest;
import com.amazonaws.services.ec2.model.RunInstancesResult;
import com.amazonaws.services.ec2.model.StartInstancesRequest;
import com.amazonaws.services.ec2.model.StopInstancesRequest;
import com.amazonaws.services.ec2.model.Tag;
import com.amazonaws.services.ec2.model.TerminateInstancesRequest;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Result;
import br.unifor.ppgia.awsda.SessionHolder;
import br.unifor.ppgia.awsda.model.CreateInstanceModel;

@Controller
@Path("instances")
public class InstanceController {

	private final Result result;
	private final AmazonEC2Client ec2;
	private final SessionHolder session;

	/**
	 * @deprecated CDI eyes only
	 */
	protected InstanceController() {
		this(null, null, null);
	}

	@Inject
	public InstanceController(Result result, AmazonEC2Client ec2, SessionHolder session) {
		this.result = result;
		this.ec2 = ec2;
		this.session = session;
	}

	@Path("/")
	public void index() {
		result.redirectTo(this).list();
	}

	@Path("create")
	public void create(CreateInstanceModel model) {
		RunInstancesRequest runInstancesRequest = new RunInstancesRequest();

		runInstancesRequest.withImageId(model.getAmiId()).withMinCount(1).withMaxCount(1)
				.withInstanceType(model.getInstanceType()).withKeyName("homework-cloud")
				.withSecurityGroups(new ArrayList<String>());

		RunInstancesResult runInstances = ec2.runInstances(runInstancesRequest);
		List<Instance> instances = runInstances.getReservation().getInstances();
		for (Instance instance : instances) {
			CreateTagsRequest createTagsRequest = new CreateTagsRequest();
			createTagsRequest.withResources(instance.getInstanceId()).withTags(new Tag("Name", model.getInstanceName()),
					new Tag("Description", model.getInstanceDescription()));
			ec2.createTags(createTagsRequest);
		}

		result.redirectTo(this).list();
	}

	@Get("add")
	public void ami() {
		DescribeImagesRequest dir = new DescribeImagesRequest();

		Filter f = new Filter("root-device-type", asList("ebs"));
		Filter f2 = new Filter("block-device-mapping.volume-type", asList("gp2"));
		Filter f3 = new Filter("image-type", asList("machine"));
		Filter f4 = new Filter("owner-alias", asList("amazon"));
		Filter f5 = new Filter("state", asList("available"));
		Filter f6 = new Filter("virtualization-type", asList("hvm"));

		dir.setFilters(asList(f, f2, f3, f4, f5, f6));

		DescribeImagesResult describeImages = ec2.describeImages(dir);

		result.include("regionEndpoint", session.selectedRegion().getEndpoint());
		result.include("images", describeImages.getImages().subList(0, 200));
		result.include("instanceType", CreateInstanceModel.instanceTypes());
	}

	@Path("/list")
	public void list() {
		DescribeInstancesResult results = ec2.describeInstances();
		List<Reservation> reservations = results.getReservations();
		List<Instance> ins = new ArrayList<Instance>();

		for (Reservation reservation : reservations) {
			ins.addAll(reservation.getInstances());
		}

		result.include("instances", ins);
		result.include("regionEndpoint", session.selectedRegion().getEndpoint());
	}

	@Get("/terminate/{id}")
	public void terminate(String id) {
		ec2.setEndpoint("ec2.us-west-2.amazonaws.com");
		TerminateInstancesRequest request = new TerminateInstancesRequest(asList(id));
		ec2.terminateInstances(request);

		result.redirectTo(this).list();
	}

	@Get("/stop/{id}")
	public void stop(String id) {
		ec2.setEndpoint("ec2.us-west-2.amazonaws.com");
		StopInstancesRequest request = new StopInstancesRequest(asList(id));
		ec2.stopInstances(request);

		result.redirectTo(this).list();
	}

	@Get("/start/{id}")
	public void start(String id) {
		ec2.setEndpoint("ec2.us-west-2.amazonaws.com");
		StartInstancesRequest request = new StartInstancesRequest(asList(id));
		ec2.startInstances(request);

		result.redirectTo(this).list();
	}
}

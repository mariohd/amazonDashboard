package br.unifor.ppgia.awsda.controller;

import java.util.Optional;

import javax.inject.Inject;

import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.model.DescribeRegionsResult;
import com.amazonaws.services.ec2.model.Region;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Result;
import br.unifor.ppgia.awsda.SessionHolder;

@Controller
@Path("regions")
public class RegionsController {
	private final Result result;
	private final AmazonEC2Client ec2;
	private final SessionHolder session;

	/**
	 * @deprecated CDI eyes only
	 */
	protected RegionsController() {
		this(null, null, null);
	}

	@Inject
	public RegionsController(Result result, AmazonEC2Client ec2, SessionHolder session) {
		this.result = result;
		this.ec2 = ec2;
		this.session = session;
	}

	@Get("/")
	public void index() {
		if (session.regions().isEmpty()) {
			DescribeRegionsResult describeRegions = ec2.describeRegions();
			session.regions(describeRegions.getRegions());
		}

		result.include("regions", session.regions());
		result.include("selectedRegion", session.selectedRegion());
	}

	@Post("/select")
	public void select(String regionEndpoint) {
		Optional<Region> region = session.findByEndpoint(regionEndpoint);
		if (region.isPresent()) {
			session.selectRegion(region.get());
			result.redirectTo(this).index();
		} else {
			result.notFound();
		}
	}
}

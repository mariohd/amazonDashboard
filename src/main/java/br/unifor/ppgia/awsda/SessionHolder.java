package br.unifor.ppgia.awsda;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

import com.amazonaws.services.ec2.model.Region;

@SessionScoped
@Named("session")
public class SessionHolder implements Serializable {

	private static final long serialVersionUID = 1L;
	private Region selectedRegion;
	private List<Region> regions;

	public SessionHolder() {
		this.selectedRegion = defaultRegion();
		this.regions = Collections.emptyList();
	}

	public Region defaultRegion() {
		return new Region().withEndpoint("ec2.us-west-2.amazonaws.com").withRegionName("ec2.us-west-2");
	}

	public Region selectedRegion() {
		if (selectedRegion == null || "".equals(selectedRegion.getEndpoint())) {
			selectRegion(defaultRegion());
		}
		return selectedRegion;
	}

	public void selectRegion(Region region) {
		this.selectedRegion = region;
	}

	public List<Region> regions() {
		return regions;
	}

	public void regions(List<Region> regions) {
		this.regions = regions;
	}

	public Optional<Region> findByEndpoint(String endpoint) {
		return regions().stream().filter(p -> p.getEndpoint().equals(endpoint)).findFirst();
	}
}

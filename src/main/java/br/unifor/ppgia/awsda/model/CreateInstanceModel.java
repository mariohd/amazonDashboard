package br.unifor.ppgia.awsda.model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Iterator;

import com.amazonaws.services.ec2.model.InstanceType;

public class CreateInstanceModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private String regionEndpoint;
	private String instanceName;
	private String instanceDescription;
	private String amiId;
	private InstanceType instanceType;

	public String getRegionEndpoint() {
		return regionEndpoint;
	}

	public void setRegionEndpoint(String regionEndpoint) {
		this.regionEndpoint = regionEndpoint;
	}

	public String getInstanceName() {
		return instanceName;
	}

	public void setInstanceName(String instanceName) {
		this.instanceName = instanceName;
	}

	public String getInstanceDescription() {
		return instanceDescription;
	}

	public void setInstanceDescription(String instanceDescription) {
		this.instanceDescription = instanceDescription;
	}

	public String getAmiId() {
		return amiId;
	}

	public void setAmiId(String amiId) {
		this.amiId = amiId;
	}

	public InstanceType getInstanceType() {
		return instanceType;
	}

	public void setInstanceType(String instanceType) {
		this.instanceType = InstanceType.fromValue(instanceType);
	}

	public static Iterator<String> instanceTypes() {
		return Arrays.asList(InstanceType.values()).stream().map(i -> i.toString()).iterator();
	}
}

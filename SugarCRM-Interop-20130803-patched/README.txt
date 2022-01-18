SugarCRM TOSCA ServiceTemplate according to TOSCA-v1.0-cs02
===========================================================

This Cloud Service Archive (CSAR) contains the TOSCA Service Template for the
SugarCRM interoperability example according to the TOSCA v1.0 specification.

The CSAR file contains TOSCA definitions and artifacts that allow for deploying
the SugarCRM Community Edition under the assumptions made below.

The deployed SugarCRM application will be avaiable at the following URL:
http://<hostname or IP of web tier VM>/sugarcrm
Default user ID and password for SugarCRM are: crmadmin/crm123
Those values are set as node properties of the SugarCrmApp Node Template in the
SugarCRM service template.

Assumptions for deploying SugarCRM using this CSAR:

* This CSAR does not include any VM images as base for deployment, nor does it
  define explicit requirements against a specific platform or operating system.
  The target environment is assumed to provide a Red Hat Enterprise Linux (RHEL)
  version 6.3 x86_64 base image for the virtual machines being deployed for the
  SugarCRM service.
* The base operating system image is not required to include any of the RPM
  packages for components of the SugarCRM service. Those packages will be
  installed according to Deployment Artifact definitions of the Service Template
  or related definitions, respectively.
* All the automation is provided in the form of bash scripts. The executing
  TOSCA container has to provide means for executing those scripts on the
  deployed virtual machines. The way in which this is achieved is implementation
  specific and not governed by the TOSCA specification.

Also, please note the following:

* All the type definitions (NodeTypes, RelationshipTypes etc.) are
  based on definitions of non-normative TOSCA Base and Specific Types
  that have been defined in discussions of the TOSCA Interop SC.
  All such type definitions are contained in separate Definitions XML
  files that are imported into the main Definitions file containing
  the SugarCRM Service Template.

* For Artifacts, we created some type definitions based on implementation
  needs so far, where we made simplifying assumptions.
  Please consider this a base for discussion and potential area of refinement.

* We have removed the SugarCRM CE installable zip file from the CSAR's
  files directory to keep the archive small and to not redistribute the file
  for legal reasons.
  Before deploying this CSAR, please obtain the current SugarCRM Community
  Edition installable zip file (version assumed by this CSAR is 6.5.14) for
  Linux from the SugarCRM web site and place it into the files directory of
  this CSAR.

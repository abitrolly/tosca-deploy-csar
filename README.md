### Installation and deployment

1. Install xOpera and Ansible
```
./01install-xopera.sh
```

2. Download example CSAR [`SugarCRM-Interop-20130803.zip`](https://www.oasis-open.org/committees/document.php?document_id=50158) (included in this repo)
3. Try to deploy it with xOpera and watch it fail
```
$ opera validate SugarCRM-Interop-20130803.zip
Validating CSAR...
TOSCA-Metadata/TOSCA.meta: Missing required meta entry: TOSCA-Meta-File-Version
$ opera deploy SugarCRM-Interop-20130803.zip
TOSCA-Metadata/TOSCA.meta: Missing required meta entry: TOSCA-Meta-File-Version
```
3. Unpack CSAR into `SugarCRM-Interop-20130803-patched/` dir and use it with xOpera
```
unzip SugarCRM-Interop-20130803.zip -d SugarCRM-Interop-20130803-patched
```
4. Fix invalid CSAR parts
 * [x] Replaced invalid `TOSCA-Meta-Version` with `TOSCA-Meta-File-Version` ([see the spec](http://docs.oasis-open.org/tosca/TOSCA/v1.0/os/TOSCA-v1.0-os.html))
```
$ opera validate SugarCRM-Interop-20130803-patched/
Validating CSAR...
TOSCA-Metadata/TOSCA.meta: CSAR-Version 1.0 is not supported. Supported versions: {'1.1'}".
```
 * [x] Bump `CSAR-Version` to 1.1 which looks compatible ([from another spec](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.1/csprd01/TOSCA-Simple-Profile-YAML-v1.1-csprd01.html#_Toc464060446))
```
$ opera validate SugarCRM-Interop-20130803-patched/
Validating CSAR...
TOSCA-Metadata/TOSCA.meta: TOSCA-Meta-File-Version 1.0 is not supported. Supported versions: {'1.1'}".
```
4. Improvise
5. Overcome
6. Roadbump
 * [ ] Find and add missing `SugarCE-6.5.14.zip` to the CSAR archive
 * [ ] Repeat `opera validate`
 * [ ] (probably) Rewrite TOSCA 1.0 XML into 1.3 YAML
 * [ ] Replace Bash scripts with Ansible playbooks
 * [ ] (probably) Adapt node definitions for xOpera
7. [ ] Deploy CSAR to localhost
```
`bash 02deploy.sh` to deploy hello app to localhost
```
8. [ ] Open http://locahost (probably) to see SugarCRM running

### Testing with Docker

Clone this repo.
```
git clone https://github.com/abitrolly/tosca-deploy-csar
cd tosca-deploy-csar
```

The command below runs docker image with Ubuntu 21.04, mounts
current dir there as `/root/tosca` and maps
http://locahost:9999 to port 80 web inside.

```
docker run -v "$(pwd):/root/tosca":Z -w "/root/tosca" -it -p 9999:80 ubuntu:21.04
```

1. Check that http://locahost:9999 shows standard Apache 2 page.
2. Follow installation and deployment instructions in container shell
3. Check that http://locahost:9999 now shows SugarCRM page

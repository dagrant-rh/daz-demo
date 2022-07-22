# simple-bash
A simple Bash script that generates audit-like events to stdout.

## Log event format
Events are generated in the following format:

```
Timestamp="<epoch seconds>"
Host="Hostname of the container, derived from $HOSTNAME"
pid="<PID of the process>"
Event="<Name of the audit event, randomly selected from data/events.txt>"
Status="<Status of the event, Success or Failure>"
User="<Firstname and surname of the user, derived from lists of names from https://en.wiktionary.org/wiki/Appendix:Names"
```

## Example events:

**Note: User names are generated randomly and any resemblance to a real person, is purely coincidental!*

```
Timestamp="1657194208" Host="f95d847050b1" pid="1" Event="admin_logout" Status="Success" User="Romatu Ashby"
Timestamp="1657194213" Host="f95d847050b1" pid="1" Event="deleted_record" Status="Failure" User="Mlelwa de Graaff"
Timestamp="1657194218" Host="f95d847050b1" pid="1" Event="user_login" Status="Success" User="Torkel Welmers"
Timestamp="1657194224" Host="f95d847050b1" pid="1" Event="modified_record" Status="Success" User="Hjördis Kukla"
```

## Deploying on OpenShift

To deploy:

```
git clone https://github.com/dagrant-rh/daz-demos.git
cd daz-demos/simple-bash
oc login -u <username> -p <password> https://<OCP API URL>:6443
oc apply -k deploy/base/ # or deploy/overlays/<dev|test|prod> for environment specific kustomization examples
oc logs -f deployment/simple-bash -n daz-demos-simple-bash # to view logs

```

To tear down the app:
```
oc delete -k deploy/
```

## Building the container image

To build the container image and push to your own registry:

```
git clone https://github.com/dagrant-rh/daz-demos.git
cd daz-demos/simple-bash/src

podman login quay.io # Enter your registry username and password when prompted
podman login registry.rehat.io # Enter your registry username and password when prompted

./BuildPush.sh # Follow prompts

```




# Authentication Provider

## Keycloak

Use the Job job_secret_cm.yaml to create these secrets or create them manually

```bash
oc create secret generic keycloak-db-secret \
--from-literal=username=keycloak \
--from-literal=password=[your_database_password] -n keycloak
```

Create shared client secret

```bash
oc create secret generic kc-client-secret \
--from-literal=clientSecret=[client-secret] -n openshift-config
```

```bash
oc create secret generic kc-client-secret \
--from-literal=clientSecret=[client-secret] -n keycloak
```

Apply the yaml files to create the database and the keycloak instance.
Get the credentials with the following command.

```bash
oc get secret kc-sso-initial-admin -o jsonpath='{.data.username}' | base64 --decode
oc get secret kc-sso-initial-admin -o jsonpath='{.data.password}' | base64 --decode
```

## Htpasswd

Create the htpasswd file

```bash
htpasswd -c -B -b htpasswd <username> <password>
```

Add additional users

```bash
htpasswd -b htpasswd <username> <password>
```

Create a htpasswd secret

```bash
oc create secret generic htpass-secret --from-file=htpasswd=htpasswd -n openshift-config
```

If you need to add additional users you can update the htpasswd secret with

```bash
oc set data secret htpass-secret --from-file=htpasswd=htpasswd -n openshift-config
```
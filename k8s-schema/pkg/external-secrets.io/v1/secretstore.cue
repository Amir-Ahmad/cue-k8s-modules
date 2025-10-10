package v1

import (
	"strings"
	"struct"
	"time"
)

#SecretStore: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind?: string
	metadata?: {}

	// SecretStoreSpec defines the desired state of SecretStore.
	spec?: {
		// Used to constraint a ClusterSecretStore to specific namespaces.
		// Relevant only to ClusterSecretStore
		conditions?: [...{
			// Choose namespaces by using regex matching
			namespaceRegexes?: [...string]

			// Choose namespace using a labelSelector
			namespaceSelector?: {
				// matchExpressions is a list of label selector requirements. The
				// requirements are ANDed.
				matchExpressions?: [...{
					// key is the label key that the selector applies to.
					key!: string

					// operator represents a key's relationship to a set of values.
					// Valid operators are In, NotIn, Exists and DoesNotExist.
					operator!: string

					// values is an array of string values. If the operator is In or
					// NotIn,
					// the values array must be non-empty. If the operator is Exists
					// or DoesNotExist,
					// the values array must be empty. This array is replaced during a
					// strategic
					// merge patch.
					values?: [...string]
				}]

				// matchLabels is a map of {key,value} pairs. A single {key,value}
				// in the matchLabels
				// map is equivalent to an element of matchExpressions, whose key
				// field is "key", the
				// operator is "In", and the values array contains only "value".
				// The requirements are ANDed.
				matchLabels?: [string]: string
			}

			// Choose namespaces by name
			namespaces?: [...strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"]
		}]

		// Used to select the correct ESO controller (think:
		// ingress.ingressClassName)
		// The ESO controller is instantiated with a specific controller
		// name and filters ES based on this property
		controller?: string

		// Used to configure the provider. Only one provider may be set
		provider!: struct.MinFields(
			1) & struct.MaxFields(
			1) & {
				// Akeyless configures this store to sync secrets using Akeyless
				// Vault provider
				akeyless?: {
					// Akeyless GW API Url from which the secrets to be fetched from.
					akeylessGWApiURL!: string

					// Auth configures how the operator authenticates with Akeyless.
					authSecretRef!: {
						// Kubernetes authenticates with Akeyless by passing the
						// ServiceAccount
						// token stored in the named Secret resource.
						kubernetesAuth?: {
							// the Akeyless Kubernetes auth-method access-id
							accessID!: string

							// Kubernetes-auth configuration name in Akeyless-Gateway
							k8sConfName!: string

							// Optional secret field containing a Kubernetes ServiceAccount
							// JWT used
							// for authenticating with Akeyless. If a name is specified
							// without a key,
							// `token` is the default. If one is not specified, the one bound
							// to
							// the controller will be used.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Optional service account field containing the name of a
							// kubernetes ServiceAccount.
							// If the service account is specified, the service account secret
							// token JWT will be used
							// for authenticating with Akeyless. If the service account
							// selector is not supplied,
							// the secretRef will be used instead.
							serviceAccountRef?: {
								// Audience specifies the `aud` claim for the service account
								// token
								// If the service account uses a well-known annotation for e.g.
								// IRSA or GCP Workload Identity
								// then this audiences will be appended to the list
								audiences?: [...string]

								// The name of the ServiceAccount resource being referred to.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Namespace of the resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// Reference to a Secret that contains the details
						// to authenticate with Akeyless.
						secretRef?: {
							// The SecretAccessID is used for authentication
							accessID?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							accessType?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							accessTypeParam?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// PEM/base64 encoded CA bundle used to validate Akeyless Gateway
					// certificate. Only used
					// if the AkeylessGWApiURL URL is using HTTPS protocol. If not set
					// the system root certificates
					// are used to validate the TLS connection.
					caBundle?: string

					// The provider for the CA bundle to use to validate Akeyless
					// Gateway certificate.
					caProvider?: {
						// The key where the CA certificate can be found in the Secret or
						// ConfigMap.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the object located at the provider type.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace the Provider type is in.
						// Can only be defined when used in a ClusterSecretStore.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// The type of provider to use such as "Secret", or "ConfigMap".
						type!: "Secret" | "ConfigMap"
					}
				}

				// Alibaba configures this store to sync secrets using Alibaba
				// Cloud provider
				alibaba?: {
					// AlibabaAuth contains a secretRef for credentials.
					auth!: {
						// Authenticate against Alibaba using RRSA.
						rrsa?: {
							oidcProviderArn!:   string
							oidcTokenFilePath!: string
							roleArn!:           string
							sessionName!:       string
						}

						// AlibabaAuthSecretRef holds secret references for Alibaba
						// credentials.
						secretRef?: {
							// The AccessKeyID is used for authentication
							accessKeyIDSecretRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// The AccessKeySecret is used for authentication
							accessKeySecretSecretRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// Alibaba Region to be used for the provider
					regionID!: string
				}

				// AWS configures this store to sync secrets using AWS Secret
				// Manager provider
				aws?: {
					// AdditionalRoles is a chained list of Role ARNs which the
					// provider will sequentially assume before assuming the Role
					additionalRoles?: [...string]

					// Auth defines the information necessary to authenticate against
					// AWS
					// if not set aws sdk will infer credentials from your environment
					// see:
					// https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials
					auth?: {
						// Authenticate against AWS using service account tokens.
						jwt?: {
							// A reference to a ServiceAccount resource.
							serviceAccountRef?: {
								// Audience specifies the `aud` claim for the service account
								// token
								// If the service account uses a well-known annotation for e.g.
								// IRSA or GCP Workload Identity
								// then this audiences will be appended to the list
								audiences?: [...string]

								// The name of the ServiceAccount resource being referred to.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Namespace of the resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// AWSAuthSecretRef holds secret references for AWS credentials
						// both AccessKeyID and SecretAccessKey must be defined in order
						// to properly authenticate.
						secretRef?: {
							// The AccessKeyID is used for authentication
							accessKeyIDSecretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// The SecretAccessKey is used for authentication
							secretAccessKeySecretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// The SessionToken used for authentication
							// This must be defined if AccessKeyID and SecretAccessKey are
							// temporary credentials
							// see:
							// https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html
							sessionTokenSecretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// AWS External ID set on assumed IAM roles
					externalID?: string

					// Prefix adds a prefix to all retrieved values.
					prefix?: string

					// AWS Region to be used for the provider
					region!: string

					// Role is a Role ARN which the provider will assume
					role?: string

					// SecretsManager defines how the provider behaves when
					// interacting with AWS SecretsManager
					secretsManager?: {
						// Specifies whether to delete the secret without any recovery
						// window. You
						// can't use both this parameter and RecoveryWindowInDays in the
						// same call.
						// If you don't use either, then by default Secrets Manager uses a
						// 30 day
						// recovery window.
						// see:
						// https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html#SecretsManager-DeleteSecret-request-ForceDeleteWithoutRecovery
						forceDeleteWithoutRecovery?: bool

						// The number of days from 7 to 30 that Secrets Manager waits
						// before
						// permanently deleting the secret. You can't use both this
						// parameter and
						// ForceDeleteWithoutRecovery in the same call. If you don't use
						// either,
						// then by default Secrets Manager uses a 30 day recovery window.
						// see:
						// https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html#SecretsManager-DeleteSecret-request-RecoveryWindowInDays
						recoveryWindowInDays?: int64 & int
					}

					// Service defines which service should be used to fetch the
					// secrets
					service!: "SecretsManager" | "ParameterStore"

					// AWS STS assume role session tags
					sessionTags?: [...{
						key!:   string
						value!: string
					}]

					// AWS STS assume role transitive session tags. Required when
					// multiple rules are used with the provider
					transitiveTagKeys?: [...string]
				}

				// AzureKV configures this store to sync secrets using Azure Key
				// Vault provider
				azurekv?: {
					// Auth configures how the operator authenticates with Azure.
					// Required for ServicePrincipal auth type. Optional for
					// WorkloadIdentity.
					authSecretRef?: {
						// The Azure ClientCertificate of the service principle used for
						// authentication.
						clientCertificate?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// The Azure clientId of the service principle or managed identity
						// used for authentication.
						clientId?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// The Azure ClientSecret of the service principle used for
						// authentication.
						clientSecret?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// The Azure tenantId of the managed identity used for
						// authentication.
						tenantId?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// Auth type defines how to authenticate to the keyvault service.
					// Valid values are:
					// - "ServicePrincipal" (default): Using a service principal
					// (tenantId, clientId, clientSecret)
					// - "ManagedIdentity": Using Managed Identity assigned to the pod
					// (see aad-pod-identity)
					authType?: "ServicePrincipal" | "ManagedIdentity" | "WorkloadIdentity"

					// CustomCloudConfig defines custom Azure Stack Hub or Azure Stack
					// Edge endpoints.
					// Required when EnvironmentType is AzureStackCloud.
					// IMPORTANT: This feature REQUIRES UseAzureSDK to be set to true.
					// Custom cloud
					// configuration is not supported with the legacy go-autorest SDK.
					customCloudConfig?: {
						// ActiveDirectoryEndpoint is the AAD endpoint for authentication
						// Required when using custom cloud configuration
						activeDirectoryEndpoint!: string

						// KeyVaultDNSSuffix is the DNS suffix for Key Vault URLs
						keyVaultDNSSuffix?: string

						// KeyVaultEndpoint is the Key Vault service endpoint
						keyVaultEndpoint?: string

						// ResourceManagerEndpoint is the Azure Resource Manager endpoint
						resourceManagerEndpoint?: string
					}

					// EnvironmentType specifies the Azure cloud environment endpoints
					// to use for
					// connecting and authenticating with Azure. By default it points
					// to the public cloud AAD endpoint.
					// The following endpoints are available, also see here:
					// https://github.com/Azure/go-autorest/blob/main/autorest/azure/environments.go#L152
					// PublicCloud, USGovernmentCloud, ChinaCloud, GermanCloud,
					// AzureStackCloud
					// Use AzureStackCloud when you need to configure custom Azure
					// Stack Hub or Azure Stack Edge endpoints.
					environmentType?: "PublicCloud" | "USGovernmentCloud" | "ChinaCloud" | "GermanCloud" | "AzureStackCloud"

					// If multiple Managed Identity is assigned to the pod, you can
					// select the one to be used
					identityId?: string

					// ServiceAccountRef specified the service account
					// that should be used when authenticating with WorkloadIdentity.
					serviceAccountRef?: {
						// Audience specifies the `aud` claim for the service account
						// token
						// If the service account uses a well-known annotation for e.g.
						// IRSA or GCP Workload Identity
						// then this audiences will be appended to the list
						audiences?: [...string]

						// The name of the ServiceAccount resource being referred to.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Namespace of the resource being referred to.
						// Ignored if referent is not cluster-scoped, otherwise defaults
						// to the namespace of the referent.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
					}

					// TenantID configures the Azure Tenant to send requests to.
					// Required for ServicePrincipal auth type. Optional for
					// WorkloadIdentity.
					tenantId?: string

					// UseAzureSDK enables the use of the new Azure SDK for Go
					// (azcore-based) instead of the legacy go-autorest SDK.
					// This is experimental and may have behavioral differences.
					// Defaults to false (legacy SDK).
					useAzureSDK?: bool

					// Vault Url from which the secrets to be fetched from.
					vaultUrl!: string
				}

				// Beyondtrust configures this store to sync secrets using
				// Password Safe provider.
				beyondtrust?: {
					// Auth configures how the operator authenticates with
					// Beyondtrust.
					auth!: {
						// APIKey If not provided then ClientID/ClientSecret become
						// required.
						apiKey?: {
							// SecretRef references a key in a secret that will be used as
							// value.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Value can be specified directly to set a value without using a
							// secret.
							value?: string
						}

						// Certificate (cert.pem) for use when authenticating with an
						// OAuth client Id using a Client Certificate.
						certificate?: {
							// SecretRef references a key in a secret that will be used as
							// value.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Value can be specified directly to set a value without using a
							// secret.
							value?: string
						}

						// Certificate private key (key.pem). For use when authenticating
						// with an OAuth client Id
						certificateKey?: {
							// SecretRef references a key in a secret that will be used as
							// value.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Value can be specified directly to set a value without using a
							// secret.
							value?: string
						}

						// ClientID is the API OAuth Client ID.
						clientId?: {
							// SecretRef references a key in a secret that will be used as
							// value.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Value can be specified directly to set a value without using a
							// secret.
							value?: string
						}

						// ClientSecret is the API OAuth Client Secret.
						clientSecret?: {
							// SecretRef references a key in a secret that will be used as
							// value.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Value can be specified directly to set a value without using a
							// secret.
							value?: string
						}
					}

					// Auth configures how API server works.
					server!: {
						apiUrl!:     string
						apiVersion?: string

						// Timeout specifies a time limit for requests made by this
						// Client. The timeout includes connection time, any redirects,
						// and reading the response body. Defaults to 45 seconds.
						clientTimeOutSeconds?: int

						// The secret retrieval type. SECRET = Secrets Safe (credential,
						// text, file). MANAGED_ACCOUNT = Password Safe account
						// associated with a system.
						retrievalType?: string

						// A character that separates the folder names.
						separator?: string
						verifyCA!:  bool
					}
				}

				// BitwardenSecretsManager configures this store to sync secrets
				// using BitwardenSecretsManager provider
				bitwardensecretsmanager?: {
					apiURL?: string

					// Auth configures how secret-manager authenticates with a
					// bitwarden machine account instance.
					// Make sure that the token being used has permissions on the
					// given secret.
					auth!: {
						// BitwardenSecretsManagerSecretRef contains the credential ref to
						// the bitwarden instance.
						secretRef!: {
							// AccessToken used for the bitwarden instance.
							credentials!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}
					bitwardenServerSDKURL?: string

					// Base64 encoded certificate for the bitwarden server sdk. The
					// sdk MUST run with HTTPS to make sure no MITM attack
					// can be performed.
					caBundle?: string

					// see:
					// https://external-secrets.io/latest/spec/#external-secrets.io/v1alpha1.CAProvider
					caProvider?: {
						// The key where the CA certificate can be found in the Secret or
						// ConfigMap.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the object located at the provider type.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace the Provider type is in.
						// Can only be defined when used in a ClusterSecretStore.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// The type of provider to use such as "Secret", or "ConfigMap".
						type!: "Secret" | "ConfigMap"
					}
					identityURL?: string

					// OrganizationID determines which organization this secret store
					// manages.
					organizationID!: string

					// ProjectID determines which project this secret store manages.
					projectID!: string
				}

				// Chef configures this store to sync secrets with chef server
				chef?: {
					// Auth defines the information necessary to authenticate against
					// chef Server
					auth!: {
						// ChefAuthSecretRef holds secret references for chef server login
						// credentials.
						secretRef!: {
							// SecretKey is the Signing Key in PEM format, used for
							// authentication.
							privateKeySecretRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// ServerURL is the chef server URL used to connect to. If using
					// orgs you should include your org in the url and terminate the
					// url with a "/"
					serverUrl!: string

					// UserName should be the user ID on the chef server
					username!: string
				}

				// CloudruSM configures this store to sync secrets using the
				// Cloud.ru Secret Manager provider
				cloudrusm?: {
					// CSMAuth contains a secretRef for credentials.
					auth!: {
						// CSMAuthSecretRef holds secret references for Cloud.ru
						// credentials.
						secretRef?: {
							// The AccessKeyID is used for authentication
							accessKeyIDSecretRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// The AccessKeySecret is used for authentication
							accessKeySecretSecretRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// ProjectID is the project, which the secrets are stored in.
					projectID?: string
				}

				// Conjur configures this store to sync secrets using conjur
				// provider
				conjur?: {
					// Defines authentication settings for connecting to Conjur.
					auth!: {
						// Authenticates with Conjur using an API key.
						apikey?: {
							// Account is the Conjur organization account name.
							account!: string

							// A reference to a specific 'key' containing the Conjur API key
							// within a Secret resource. In some instances, `key` is a
							// required field.
							apiKeyRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' containing the Conjur username
							// within a Secret resource. In some instances, `key` is a
							// required field.
							userRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// Jwt enables JWT authentication using Kubernetes service account
						// tokens.
						jwt?: {
							// Account is the Conjur organization account name.
							account!: string

							// Optional HostID for JWT authentication. This may be used
							// depending
							// on how the Conjur JWT authenticator policy is configured.
							hostId?: string

							// Optional SecretRef that refers to a key in a Secret resource
							// containing JWT token to
							// authenticate with Conjur using the JWT authentication method.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Optional ServiceAccountRef specifies the Kubernetes service
							// account for which to request
							// a token for with the `TokenRequest` API.
							serviceAccountRef?: {
								// Audience specifies the `aud` claim for the service account
								// token
								// If the service account uses a well-known annotation for e.g.
								// IRSA or GCP Workload Identity
								// then this audiences will be appended to the list
								audiences?: [...string]

								// The name of the ServiceAccount resource being referred to.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Namespace of the resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// The conjur authn jwt webservice id
							serviceID!: string
						}
					}

					// CABundle is a PEM encoded CA bundle that will be used to
					// validate the Conjur server certificate.
					caBundle?: string

					// Used to provide custom certificate authority (CA) certificates
					// for a secret store. The CAProvider points to a Secret or
					// ConfigMap resource
					// that contains a PEM-encoded certificate.
					caProvider?: {
						// The key where the CA certificate can be found in the Secret or
						// ConfigMap.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the object located at the provider type.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace the Provider type is in.
						// Can only be defined when used in a ClusterSecretStore.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// The type of provider to use such as "Secret", or "ConfigMap".
						type!: "Secret" | "ConfigMap"
					}

					// URL is the endpoint of the Conjur instance.
					url!: string
				}

				// Delinea DevOps Secrets Vault
				// https://docs.delinea.com/online-help/products/devops-secrets-vault/current
				delinea?: {
					// ClientID is the non-secret part of the credential.
					clientId!: {
						// SecretRef references a key in a secret that will be used as
						// value.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// Value can be specified directly to set a value without using a
						// secret.
						value?: string
					}

					// ClientSecret is the secret part of the credential.
					clientSecret!: {
						// SecretRef references a key in a secret that will be used as
						// value.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// Value can be specified directly to set a value without using a
						// secret.
						value?: string
					}

					// Tenant is the chosen hostname / site name.
					tenant!: string

					// TLD is based on the server location that was chosen during
					// provisioning.
					// If unset, defaults to "com".
					tld?: string

					// URLTemplate
					// If unset, defaults to
					// "https://%s.secretsvaultcloud.%s/v1/%s%s".
					urlTemplate?: string
				}

				// Device42 configures this store to sync secrets using the
				// Device42 provider
				device42?: {
					// Auth configures how secret-manager authenticates with a
					// Device42 instance.
					auth!: secretRef!: {
						// Username / Password is used for authentication.
						credentials?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// URL configures the Device42 instance URL.
					host!: string
				}

				// Doppler configures this store to sync secrets using the Doppler
				// provider
				doppler?: {
					// Auth configures how the Operator authenticates with the Doppler
					// API
					auth!: secretRef!: {
						// The DopplerToken is used for authentication.
						// See https://docs.doppler.com/reference/api#authentication for
						// auth token types.
						// The Key attribute defaults to dopplerToken if not specified.
						dopplerToken!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// Doppler config (required if not using a Service Token)
					config?: string

					// Format enables the downloading of secrets as a file (string)
					format?: "json" | "dotnet-json" | "env" | "yaml" | "docker"

					// Environment variable compatible name transforms that change
					// secret names to a different format
					nameTransformer?: "upper-camel" | "camel" | "lower-snake" | "tf-var" | "dotnet-env" | "lower-kebab"

					// Doppler project (required if not using a Service Token)
					project?: string
				}

				// Fake configures a store with static key/value pairs
				fake?: {
					data!: [...{
						key!:     string
						value!:   string
						version?: string
					}]
					validationResult?: int
				}

				// Fortanix configures this store to sync secrets using the
				// Fortanix provider
				fortanix?: {
					// APIKey is the API token to access SDKMS Applications.
					apiKey?: {
						// SecretRef is a reference to a secret containing the SDKMS API
						// Key.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// APIURL is the URL of SDKMS API. Defaults to
					// `sdkms.fortanix.com`.
					apiUrl?: string
				}

				// GCPSM configures this store to sync secrets using Google Cloud
				// Platform Secret Manager provider
				gcpsm?: {
					// Auth defines the information necessary to authenticate against
					// GCP
					auth?: {
						secretRef?: {
							// The SecretAccessKey is used for authentication
							secretAccessKeySecretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						workloadIdentity?: {
							// ClusterLocation is the location of the cluster
							// If not specified, it fetches information from the metadata
							// server
							clusterLocation?: string

							// ClusterName is the name of the cluster
							// If not specified, it fetches information from the metadata
							// server
							clusterName?: string

							// ClusterProjectID is the project ID of the cluster
							// If not specified, it fetches information from the metadata
							// server
							clusterProjectID?: string

							// A reference to a ServiceAccount resource.
							serviceAccountRef!: {
								// Audience specifies the `aud` claim for the service account
								// token
								// If the service account uses a well-known annotation for e.g.
								// IRSA or GCP Workload Identity
								// then this audiences will be appended to the list
								audiences?: [...string]

								// The name of the ServiceAccount resource being referred to.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Namespace of the resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// GCPWorkloadIdentityFederation holds the configurations required
						// for generating federated access tokens.
						workloadIdentityFederation?: {
							// audience is the Secure Token Service (STS) audience which
							// contains the resource name for the workload identity pool and
							// the provider identifier in that pool.
							// If specified, Audience found in the external account credential
							// config will be overridden with the configured value.
							// audience must be provided when serviceAccountRef or
							// awsSecurityCredentials is configured.
							audience?: string

							// awsSecurityCredentials is for configuring AWS region and
							// credentials to use for obtaining the access token,
							// when using the AWS metadata server is not an option.
							awsSecurityCredentials?: {
								// awsCredentialsSecretRef is the reference to the secret which
								// holds the AWS credentials.
								// Secret should be created with below names for keys
								// - aws_access_key_id: Access Key ID, which is the unique
								// identifier for the AWS account or the IAM user.
								// - aws_secret_access_key: Secret Access Key, which is used to
								// authenticate requests made to AWS services.
								// - aws_session_token: Session Token, is the short-lived token to
								// authenticate requests made to AWS services.
								awsCredentialsSecretRef!: {
									// name of the secret.
									name!: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// namespace in which the secret exists. If empty, secret will
									// looked up in local namespace.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}

								// region is for configuring the AWS region to be used.
								region!: strings.MaxRunes(
										50) & strings.MinRunes(
										1) & =~"^[a-z0-9-]+$"
							}

							// credConfig holds the configmap reference containing the GCP
							// external account credential configuration in JSON format and
							// the key name containing the json data.
							// For using Kubernetes cluster as the identity provider, use
							// serviceAccountRef instead. Operators mounted serviceaccount
							// token cannot be used as the token source, instead
							// serviceAccountRef must be used by providing operators service
							// account details.
							credConfig?: {
								// key name holding the external account credential config.
								key!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// name of the configmap.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// namespace in which the configmap exists. If empty, configmap
								// will looked up in local namespace.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// externalTokenEndpoint is the endpoint explicitly set up to
							// provide tokens, which will be matched against the
							// credential_source.url in the provided credConfig. This field is
							// merely to double-check the external token source
							// URL is having the expected value.
							externalTokenEndpoint?: string

							// serviceAccountRef is the reference to the kubernetes
							// ServiceAccount to be used for obtaining the tokens,
							// when Kubernetes is configured as provider in workload identity
							// pool.
							serviceAccountRef?: {
								// Audience specifies the `aud` claim for the service account
								// token
								// If the service account uses a well-known annotation for e.g.
								// IRSA or GCP Workload Identity
								// then this audiences will be appended to the list
								audiences?: [...string]

								// The name of the ServiceAccount resource being referred to.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Namespace of the resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// Location optionally defines a location for a secret
					location?: string

					// ProjectID project where secret is located
					projectID?: string

					// SecretVersionSelectionPolicy specifies how the provider selects
					// a secret version
					// when "latest" is disabled or destroyed.
					// Possible values are:
					// - LatestOrFail: the provider always uses "latest", or fails if
					// that version is disabled/destroyed.
					// - LatestOrFetch: the provider falls back to fetching the latest
					// version if the version is DESTROYED or DISABLED
					secretVersionSelectionPolicy?: string
				}

				// Github configures this store to push GitHub Action secrets
				// using GitHub API provider.
				// Note: This provider only supports write operations (PushSecret)
				// and cannot fetch secrets from GitHub
				github?: {
					// appID specifies the Github APP that will be used to
					// authenticate the client
					appID!: int64 & int

					// auth configures how secret-manager authenticates with a Github
					// instance.
					auth!: {
						// A reference to a specific 'key' within a Secret resource.
						// In some instances, `key` is a required field.
						privateKey!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// environment will be used to fetch secrets from a particular
					// environment within a github repository
					environment?: string

					// installationID specifies the Github APP installation that will
					// be used to authenticate the client
					installationID!: int64 & int

					// organization will be used to fetch secrets from the Github
					// organization
					organization!: string

					// repository will be used to fetch secrets from the Github
					// repository within an organization
					repository?: string

					// Upload URL for enterprise instances. Default to URL.
					uploadURL?: string

					// URL configures the Github instance URL. Defaults to
					// https://github.com/.
					url?: string
				}

				// GitLab configures this store to sync secrets using GitLab
				// Variables provider
				gitlab?: {
					// Auth configures how secret-manager authenticates with a GitLab
					// instance.
					auth!: SecretRef!: {
						// AccessToken is used for authentication.
						accessToken?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// Base64 encoded certificate for the GitLab server sdk. The sdk
					// MUST run with HTTPS to make sure no MITM attack
					// can be performed.
					caBundle?: string

					// see:
					// https://external-secrets.io/latest/spec/#external-secrets.io/v1alpha1.CAProvider
					caProvider?: {
						// The key where the CA certificate can be found in the Secret or
						// ConfigMap.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the object located at the provider type.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace the Provider type is in.
						// Can only be defined when used in a ClusterSecretStore.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// The type of provider to use such as "Secret", or "ConfigMap".
						type!: "Secret" | "ConfigMap"
					}

					// Environment environment_scope of gitlab CI/CD variables (Please
					// see
					// https://docs.gitlab.com/ee/ci/environments/#create-a-static-environment
					// on how to create environments)
					environment?: string

					// GroupIDs specify, which gitlab groups to pull secrets from.
					// Group secrets are read from left to right followed by the
					// project variables.
					groupIDs?: [...string]

					// InheritFromGroups specifies whether parent groups should be
					// discovered and checked for secrets.
					inheritFromGroups?: bool

					// ProjectID specifies a project where secrets are located.
					projectID?: string

					// URL configures the GitLab instance URL. Defaults to
					// https://gitlab.com/.
					url?: string
				}

				// IBM configures this store to sync secrets using IBM Cloud
				// provider
				ibm?: {
					// Auth configures how secret-manager authenticates with the IBM
					// secrets manager.
					auth!: struct.MinFields(
						1) & struct.MaxFields(
						1) & {
							// IBM Container-based auth with IAM Trusted Profile.
							containerAuth?: {
								iamEndpoint?: string

								// the IBM Trusted Profile
								profile!: string

								// Location the token is mounted on the pod
								tokenLocation?: string
							}
							secretRef?: {
								// The SecretAccessKey is used for authentication
								secretApiKeySecretRef?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}
						}

					// ServiceURL is the Endpoint URL that is specific to the Secrets
					// Manager service instance
					serviceUrl?: string
				}

				// Infisical configures this store to sync secrets using the
				// Infisical provider
				infisical?: {
					// Auth configures how the Operator authenticates with the
					// Infisical API
					auth!: {
						awsAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						azureAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							resource?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						gcpIamAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							serviceAccountKeyFilePath!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						gcpIdTokenAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						jwtAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							jwt!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						kubernetesAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							serviceAccountTokenPath?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						ldapAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							ldapPassword!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							ldapUsername!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						ociAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							fingerprint!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							identityId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							privateKey!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							privateKeyPassphrase?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							region!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							tenancyId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							userId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						tokenAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							accessToken!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
						universalAuthCredentials?: {
							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							clientId!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// A reference to a specific 'key' within a Secret resource.
							// In some instances, `key` is a required field.
							clientSecret!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// HostAPI specifies the base URL of the Infisical API. If not
					// provided, it defaults to "https://app.infisical.com/api".
					hostAPI?: string

					// SecretsScope defines the scope of the secrets within the
					// workspace
					secretsScope!: {
						// EnvironmentSlug is the required slug identifier for the
						// environment.
						environmentSlug!: string

						// ExpandSecretReferences indicates whether secret references
						// should be expanded. Defaults to true if not provided.
						expandSecretReferences?: bool

						// ProjectSlug is the required slug identifier for the project.
						projectSlug!: string

						// Recursive indicates whether the secrets should be fetched
						// recursively. Defaults to false if not provided.
						recursive?: bool

						// SecretsPath specifies the path to the secrets within the
						// workspace. Defaults to "/" if not provided.
						secretsPath?: string
					}
				}

				// KeeperSecurity configures this store to sync secrets using the
				// KeeperSecurity provider
				keepersecurity?: {
					// A reference to a specific 'key' within a Secret resource.
					// In some instances, `key` is a required field.
					authRef!: {
						// A key in the referenced Secret.
						// Some instances of this field may be defaulted, in others it may
						// be required.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the Secret resource being referred to.
						name?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace of the Secret resource being referred to.
						// Ignored if referent is not cluster-scoped, otherwise defaults
						// to the namespace of the referent.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
					}
					folderID!: string
				}

				// Kubernetes configures this store to sync secrets using a
				// Kubernetes cluster provider
				kubernetes?: {
					// Auth configures how secret-manager authenticates with a
					// Kubernetes instance.
					auth?: struct.MinFields(
						1) & struct.MaxFields(
						1) & {
							// has both clientCert and clientKey as secretKeySelector
							cert?: {
								// A reference to a specific 'key' within a Secret resource.
								// In some instances, `key` is a required field.
								clientCert?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}

								// A reference to a specific 'key' within a Secret resource.
								// In some instances, `key` is a required field.
								clientKey?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}

							// points to a service account that should be used for
							// authentication
							serviceAccount?: {
								// Audience specifies the `aud` claim for the service account
								// token
								// If the service account uses a well-known annotation for e.g.
								// IRSA or GCP Workload Identity
								// then this audiences will be appended to the list
								audiences?: [...string]

								// The name of the ServiceAccount resource being referred to.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Namespace of the resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// use static token to authenticate with
							token?: {
								// A reference to a specific 'key' within a Secret resource.
								// In some instances, `key` is a required field.
								bearerToken?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}
						}

					// A reference to a secret that contains the auth information.
					authRef?: {
						// A key in the referenced Secret.
						// Some instances of this field may be defaulted, in others it may
						// be required.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the Secret resource being referred to.
						name?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace of the Secret resource being referred to.
						// Ignored if referent is not cluster-scoped, otherwise defaults
						// to the namespace of the referent.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
					}

					// Remote namespace to fetch the secrets from
					remoteNamespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

					// configures the Kubernetes server Address.
					server?: {
						// CABundle is a base64-encoded CA certificate
						caBundle?: string

						// see:
						// https://external-secrets.io/v0.4.1/spec/#external-secrets.io/v1alpha1.CAProvider
						caProvider?: {
							// The key where the CA certificate can be found in the Secret or
							// ConfigMap.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the object located at the provider type.
							name!: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace the Provider type is in.
							// Can only be defined when used in a ClusterSecretStore.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

							// The type of provider to use such as "Secret", or "ConfigMap".
							type!: "Secret" | "ConfigMap"
						}

						// configures the Kubernetes server Address.
						url?: string
					}
				}

				// Ngrok configures this store to sync secrets using the ngrok
				// provider.
				ngrok?: {
					// APIURL is the URL of the ngrok API.
					apiUrl?: string

					// Auth configures how the ngrok provider authenticates with the
					// ngrok API.
					auth!: struct.MinFields(
						1) & struct.MaxFields(
						1) & {
							// APIKey is the API Key used to authenticate with ngrok. See
							// https://ngrok.com/docs/api/#authentication
							apiKey?: {
								// SecretRef is a reference to a secret containing the ngrok API
								// key.
								secretRef?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}
						}

					// Vault configures the ngrok vault to sync secrets with.
					vault!: {
						// Name is the name of the ngrok vault to sync secrets with.
						name!: string
					}
				}

				// Onboardbase configures this store to sync secrets using the
				// Onboardbase provider
				onboardbase?: {
					// APIHost use this to configure the host url for the API for
					// selfhosted installation, default is
					// https://public.onboardbase.com/api/v1/
					apiHost!: string

					// Auth configures how the Operator authenticates with the
					// Onboardbase API
					auth!: {
						// OnboardbaseAPIKey is the APIKey generated by an admin account.
						// It is used to recognize and authorize access to a project and
						// environment within onboardbase
						apiKeyRef!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// OnboardbasePasscode is the passcode attached to the API Key
						passcodeRef!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// Environment is the name of an environmnent within a project to
					// pull the secrets from
					environment!: string

					// Project is an onboardbase project that the secrets should be
					// pulled from
					project!: string
				}

				// OnePassword configures this store to sync secrets using the
				// 1Password Cloud provider
				onepassword?: {
					// Auth defines the information necessary to authenticate against
					// OnePassword Connect Server
					auth!: {
						// OnePasswordAuthSecretRef holds secret references for 1Password
						// credentials.
						secretRef!: {
							// The ConnectToken is used for authentication to a 1Password
							// Connect Server.
							connectTokenSecretRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// ConnectHost defines the OnePassword Connect Server to connect
					// to
					connectHost!: string

					// Vaults defines which OnePassword vaults to search in which
					// order
					vaults!: [string]: int
				}

				// OnePasswordSDK configures this store to use 1Password's new Go
				// SDK to sync secrets.
				onepasswordSDK?: {
					// Auth defines the information necessary to authenticate against
					// OnePassword API.
					auth!: {
						// ServiceAccountSecretRef points to the secret containing the
						// token to access 1Password vault.
						serviceAccountSecretRef!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// IntegrationInfo specifies the name and version of the
					// integration built using the 1Password Go SDK.
					// If you don't know which name and version to use, use
					// `DefaultIntegrationName` and `DefaultIntegrationVersion`,
					// respectively.
					integrationInfo?: {
						// Name defaults to "1Password SDK".
						name?: string

						// Version defaults to "v1.0.0".
						version?: string
					}

					// Vault defines the vault's name or uuid to access. Do NOT add
					// op:// prefix. This will be done automatically.
					vault!: string
				}

				// Oracle configures this store to sync secrets using Oracle Vault
				// provider
				oracle?: {
					// Auth configures how secret-manager authenticates with the
					// Oracle Vault.
					// If empty, use the instance principal, otherwise the user
					// credentials specified in Auth.
					auth?: {
						// SecretRef to pass through sensitive information.
						secretRef!: {
							// Fingerprint is the fingerprint of the API private key.
							fingerprint!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// PrivateKey is the user's API Signing Key in PEM format, used
							// for authentication.
							privatekey!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// Tenancy is the tenancy OCID where user is located.
						tenancy!: string

						// User is an access OCID specific to the account.
						user!: string
					}

					// Compartment is the vault compartment OCID.
					// Required for PushSecret
					compartment?: string

					// EncryptionKey is the OCID of the encryption key within the
					// vault.
					// Required for PushSecret
					encryptionKey?: string

					// The type of principal to use for authentication. If left blank,
					// the Auth struct will
					// determine the principal type. This optional field must be
					// specified if using
					// workload identity.
					principalType?: "" | "UserPrincipal" | "InstancePrincipal" | "Workload"

					// Region is the region where vault is located.
					region!: string

					// ServiceAccountRef specified the service account
					// that should be used when authenticating with WorkloadIdentity.
					serviceAccountRef?: {
						// Audience specifies the `aud` claim for the service account
						// token
						// If the service account uses a well-known annotation for e.g.
						// IRSA or GCP Workload Identity
						// then this audiences will be appended to the list
						audiences?: [...string]

						// The name of the ServiceAccount resource being referred to.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Namespace of the resource being referred to.
						// Ignored if referent is not cluster-scoped, otherwise defaults
						// to the namespace of the referent.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
					}

					// Vault is the vault's OCID of the specific vault where secret is
					// located.
					vault!: string
				}
				passbolt?: {
					// Auth defines the information necessary to authenticate against
					// Passbolt Server
					auth!: {
						// A reference to a specific 'key' within a Secret resource.
						// In some instances, `key` is a required field.
						passwordSecretRef!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// A reference to a specific 'key' within a Secret resource.
						// In some instances, `key` is a required field.
						privateKeySecretRef!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// Host defines the Passbolt Server to connect to
					host!: string
				}

				// Configures a store to sync secrets with a Password Depot
				// instance.
				passworddepot?: {
					// Auth configures how secret-manager authenticates with a
					// Password Depot instance.
					auth!: secretRef!: {
						// Username / Password is used for authentication.
						credentials?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// Database to use as source
					database!: string

					// URL configures the Password Depot instance URL.
					host!: string
				}

				// Previder configures this store to sync secrets using the
				// Previder provider
				previder?: {
					// PreviderAuth contains a secretRef for credentials.
					auth!: {
						// PreviderAuthSecretRef holds secret references for Previder
						// Vault credentials.
						secretRef?: {
							// The AccessToken is used for authentication
							accessToken!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}
					baseUri?: string
				}

				// Pulumi configures this store to sync secrets using the Pulumi
				// provider
				pulumi?: {
					// AccessToken is the access tokens to sign in to the Pulumi Cloud
					// Console.
					accessToken!: {
						// SecretRef is a reference to a secret containing the Pulumi API
						// token.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// APIURL is the URL of the Pulumi API.
					apiUrl?: string

					// Environment are YAML documents composed of static key-value
					// pairs, programmatic expressions,
					// dynamically retrieved values from supported providers including
					// all major clouds,
					// and other Pulumi ESC environments.
					// To create a new environment, visit
					// https://www.pulumi.com/docs/esc/environments/ for more
					// information.
					environment!: string

					// Organization are a space to collaborate on shared projects and
					// stacks.
					// To create a new organization, visit https://app.pulumi.com/ and
					// click "New Organization".
					organization!: string

					// Project is the name of the Pulumi ESC project the environment
					// belongs to.
					project!: string
				}

				// Scaleway
				scaleway?: {
					// AccessKey is the non-secret part of the api key.
					accessKey!: {
						// SecretRef references a key in a secret that will be used as
						// value.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// Value can be specified directly to set a value without using a
						// secret.
						value?: string
					}

					// APIURL is the url of the api to use. Defaults to
					// https://api.scaleway.com
					apiUrl?: string

					// ProjectID is the id of your project, which you can find in the
					// console: https://console.scaleway.com/project/settings
					projectId!: string

					// Region where your secrets are located:
					// https://developers.scaleway.com/en/quickstart/#region-and-zone
					region!: string

					// SecretKey is the non-secret part of the api key.
					secretKey!: {
						// SecretRef references a key in a secret that will be used as
						// value.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// Value can be specified directly to set a value without using a
						// secret.
						value?: string
					}
				}

				// SecretServer configures this store to sync secrets using
				// SecretServer provider
				// https://docs.delinea.com/online-help/secret-server/start.htm
				secretserver?: {
					// Domain is the secret server domain.
					domain?: string

					// Password is the secret server account password.
					password!: {
						// SecretRef references a key in a secret that will be used as
						// value.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// Value can be specified directly to set a value without using a
						// secret.
						value?: string
					}

					// ServerURL
					// URL to your secret server installation
					serverURL!: string

					// Username is the secret server account username.
					username!: {
						// SecretRef references a key in a secret that will be used as
						// value.
						secretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// Value can be specified directly to set a value without using a
						// secret.
						value?: string
					}
				}

				// Senhasegura configures this store to sync secrets using
				// senhasegura provider
				senhasegura?: {
					// Auth defines parameters to authenticate in senhasegura
					auth!: {
						clientId!: string

						// A reference to a specific 'key' within a Secret resource.
						// In some instances, `key` is a required field.
						clientSecretSecretRef!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// IgnoreSslCertificate defines if SSL certificate must be ignored
					ignoreSslCertificate?: bool

					// Module defines which senhasegura module should be used to get
					// secrets
					module!: string

					// URL of senhasegura
					url!: string
				}

				// Vault configures this store to sync secrets using Hashi
				// provider
				vault?: {
					// Auth configures how secret-manager authenticates with the Vault
					// server.
					auth?: {
						// AppRole authenticates with Vault using the App Role auth
						// mechanism,
						// with the role and secret stored in a Kubernetes Secret
						// resource.
						appRole?: {
							// Path where the App Role authentication backend is mounted
							// in Vault, e.g: "approle"
							path!: string

							// RoleID configured in the App Role authentication backend when
							// setting
							// up the authentication backend in Vault.
							roleId?: string

							// Reference to a key in a Secret that contains the App Role ID
							// used
							// to authenticate with Vault.
							// The `key` field must be specified and denotes which entry
							// within the Secret
							// resource is used as the app role id.
							roleRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Reference to a key in a Secret that contains the App Role
							// secret used
							// to authenticate with Vault.
							// The `key` field must be specified and denotes which entry
							// within the Secret
							// resource is used as the app role secret.
							secretRef!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// Cert authenticates with TLS Certificates by passing client
						// certificate, private key and ca certificate
						// Cert authentication method
						cert?: {
							// ClientCert is a certificate to authenticate using the Cert
							// Vault
							// authentication method
							clientCert?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Path where the Certificate authentication backend is mounted
							// in Vault, e.g: "cert"
							path?: string

							// SecretRef to a key in a Secret resource containing client
							// private key to
							// authenticate with Vault using the Cert authentication method
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// Iam authenticates with vault by passing a special AWS request
						// signed with AWS IAM credentials
						// AWS IAM authentication method
						iam?: {
							// AWS External ID set on assumed IAM roles
							externalID?: string

							// Specify a service account with IRSA enabled
							jwt?: {
								// A reference to a ServiceAccount resource.
								serviceAccountRef?: {
									// Audience specifies the `aud` claim for the service account
									// token
									// If the service account uses a well-known annotation for e.g.
									// IRSA or GCP Workload Identity
									// then this audiences will be appended to the list
									audiences?: [...string]

									// The name of the ServiceAccount resource being referred to.
									name!: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// Namespace of the resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}

							// Path where the AWS auth method is enabled in Vault, e.g: "aws"
							path?: string

							// AWS region
							region?: string

							// This is the AWS role to be assumed before talking to vault
							role?: string

							// Specify credentials in a Secret object
							secretRef?: {
								// The AccessKeyID is used for authentication
								accessKeyIDSecretRef?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}

								// The SecretAccessKey is used for authentication
								secretAccessKeySecretRef?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}

								// The SessionToken used for authentication
								// This must be defined if AccessKeyID and SecretAccessKey are
								// temporary credentials
								// see:
								// https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html
								sessionTokenSecretRef?: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}

							// X-Vault-AWS-IAM-Server-ID is an additional header used by Vault
							// IAM auth method to mitigate against different types of replay
							// attacks. More details here:
							// https://developer.hashicorp.com/vault/docs/auth/aws
							vaultAwsIamServerID?: string

							// Vault Role. In vault, a role describes an identity with a set
							// of permissions, groups, or policies you want to attach a user
							// of the secrets engine
							vaultRole!: string
						}

						// Jwt authenticates with Vault by passing role and JWT token
						// using the
						// JWT/OIDC authentication method
						jwt?: {
							// Optional ServiceAccountToken specifies the Kubernetes service
							// account for which to request
							// a token for with the `TokenRequest` API.
							kubernetesServiceAccountToken?: {
								// Optional audiences field that will be used to request a
								// temporary Kubernetes service
								// account token for the service account referenced by
								// `serviceAccountRef`.
								// Defaults to a single audience `vault` it not specified.
								// Deprecated: use serviceAccountRef.Audiences instead
								audiences?: [...string]

								// Optional expiration time in seconds that will be used to
								// request a temporary
								// Kubernetes service account token for the service account
								// referenced by
								// `serviceAccountRef`.
								// Deprecated: this will be removed in the future.
								// Defaults to 10 minutes.
								expirationSeconds?: int64 & int

								// Service account field containing the name of a kubernetes
								// ServiceAccount.
								serviceAccountRef!: {
									// Audience specifies the `aud` claim for the service account
									// token
									// If the service account uses a well-known annotation for e.g.
									// IRSA or GCP Workload Identity
									// then this audiences will be appended to the list
									audiences?: [...string]

									// The name of the ServiceAccount resource being referred to.
									name!: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// Namespace of the resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}

							// Path where the JWT authentication backend is mounted
							// in Vault, e.g: "jwt"
							path!: string

							// Role is a JWT role to authenticate using the JWT/OIDC Vault
							// authentication method
							role?: string

							// Optional SecretRef that refers to a key in a Secret resource
							// containing JWT token to
							// authenticate with Vault using the JWT/OIDC authentication
							// method.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// Kubernetes authenticates with Vault by passing the
						// ServiceAccount
						// token stored in the named Secret resource to the Vault server.
						kubernetes?: {
							// Path where the Kubernetes authentication backend is mounted in
							// Vault, e.g:
							// "kubernetes"
							mountPath!: string

							// A required field containing the Vault Role to assume. A Role
							// binds a
							// Kubernetes ServiceAccount with a set of Vault policies.
							role!: string

							// Optional secret field containing a Kubernetes ServiceAccount
							// JWT used
							// for authenticating with Vault. If a name is specified without a
							// key,
							// `token` is the default. If one is not specified, the one bound
							// to
							// the controller will be used.
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Optional service account field containing the name of a
							// kubernetes ServiceAccount.
							// If the service account is specified, the service account secret
							// token JWT will be used
							// for authenticating with Vault. If the service account selector
							// is not supplied,
							// the secretRef will be used instead.
							serviceAccountRef?: {
								// Audience specifies the `aud` claim for the service account
								// token
								// If the service account uses a well-known annotation for e.g.
								// IRSA or GCP Workload Identity
								// then this audiences will be appended to the list
								audiences?: [...string]

								// The name of the ServiceAccount resource being referred to.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Namespace of the resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}

						// Ldap authenticates with Vault by passing username/password pair
						// using
						// the LDAP authentication method
						ldap?: {
							// Path where the LDAP authentication backend is mounted
							// in Vault, e.g: "ldap"
							path!: string

							// SecretRef to a key in a Secret resource containing password for
							// the LDAP
							// user used to authenticate with Vault using the LDAP
							// authentication
							// method
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Username is an LDAP username used to authenticate using the
							// LDAP Vault
							// authentication method
							username!: string
						}

						// Name of the vault namespace to authenticate to. This can be
						// different than the namespace your secret is in.
						// Namespaces is a set of features within Vault Enterprise that
						// allows
						// Vault environments to support Secure Multi-tenancy. e.g: "ns1".
						// More about namespaces can be found here
						// https://www.vaultproject.io/docs/enterprise/namespaces
						// This will default to Vault.Namespace field if set, or empty
						// otherwise
						namespace?: string

						// TokenSecretRef authenticates with Vault by presenting a token.
						tokenSecretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// UserPass authenticates with Vault by passing username/password
						// pair
						userPass?: {
							// Path where the UserPassword authentication backend is mounted
							// in Vault, e.g: "userpass"
							path!: string

							// SecretRef to a key in a Secret resource containing password for
							// the
							// user used to authenticate with Vault using the UserPass
							// authentication
							// method
							secretRef?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Username is a username used to authenticate using the UserPass
							// Vault
							// authentication method
							username!: string
						}
					}

					// PEM encoded CA bundle used to validate Vault server
					// certificate. Only used
					// if the Server URL is using HTTPS protocol. This parameter is
					// ignored for
					// plain HTTP protocol connection. If not set the system root
					// certificates
					// are used to validate the TLS connection.
					caBundle?: string

					// The provider for the CA bundle to use to validate Vault server
					// certificate.
					caProvider?: {
						// The key where the CA certificate can be found in the Secret or
						// ConfigMap.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the object located at the provider type.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace the Provider type is in.
						// Can only be defined when used in a ClusterSecretStore.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// The type of provider to use such as "Secret", or "ConfigMap".
						type!: "Secret" | "ConfigMap"
					}

					// CheckAndSet defines the Check-And-Set (CAS) settings for
					// PushSecret operations.
					// Only applies to Vault KV v2 stores. When enabled, write
					// operations must include
					// the current version of the secret to prevent unintentional
					// overwrites.
					checkAndSet?: {
						// Required when true, all write operations must include a
						// check-and-set parameter.
						// This helps prevent unintentional overwrites of secrets.
						required?: bool
					}

					// ForwardInconsistent tells Vault to forward read-after-write
					// requests to the Vault
					// leader instead of simply retrying within a loop. This can
					// increase performance if
					// the option is enabled serverside.
					// https://www.vaultproject.io/docs/configuration/replication#allow_forwarding_via_header
					forwardInconsistent?: bool

					// Headers to be added in Vault request
					headers?: [string]: string

					// Name of the vault namespace. Namespaces is a set of features
					// within Vault Enterprise that allows
					// Vault environments to support Secure Multi-tenancy. e.g: "ns1".
					// More about namespaces can be found here
					// https://www.vaultproject.io/docs/enterprise/namespaces
					namespace?: string

					// Path is the mount path of the Vault KV backend endpoint, e.g:
					// "secret". The v2 KV secret engine version specific "/data" path
					// suffix
					// for fetching secrets from Vault is optional and will be
					// appended
					// if not present in specified path.
					path?: string

					// ReadYourWrites ensures isolated read-after-write semantics by
					// providing discovered cluster replication states in each
					// request.
					// More information about eventual consistency in Vault can be
					// found here
					// https://www.vaultproject.io/docs/enterprise/consistency
					readYourWrites?: bool

					// Server is the connection address for the Vault server, e.g:
					// "https://vault.example.com:8200".
					server!: string

					// The configuration used for client side related TLS
					// communication, when the Vault server
					// requires mutual authentication. Only used if the Server URL is
					// using HTTPS protocol.
					// This parameter is ignored for plain HTTP protocol connection.
					// It's worth noting this configuration is different from the "TLS
					// certificates auth method",
					// which is available under the `auth.cert` section.
					tls?: {
						// CertSecretRef is a certificate added to the transport layer
						// when communicating with the Vault server.
						// If no key for the Secret is specified, external-secret will
						// default to 'tls.crt'.
						certSecretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}

						// KeySecretRef to a key in a Secret resource containing client
						// private key
						// added to the transport layer when communicating with the Vault
						// server.
						// If no key for the Secret is specified, external-secret will
						// default to 'tls.key'.
						keySecretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// Version is the Vault KV secret engine version. This can be
					// either "v1" or
					// "v2". Version defaults to "v2".
					version?: "v1" | "v2"
				}

				// Volcengine configures this store to sync secrets using the
				// Volcengine provider
				volcengine?: {
					// Auth defines the authentication method to use.
					// If not specified, the provider will try to use IRSA (IAM Role
					// for Service Account).
					auth?: {
						// SecretRef defines the static credentials to use for
						// authentication.
						// If not set, IRSA is used.
						secretRef?: {
							// AccessKeyID is the reference to the secret containing the
							// Access Key ID.
							accessKeyID!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// SecretAccessKey is the reference to the secret containing the
							// Secret Access Key.
							secretAccessKey!: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}

							// Token is the reference to the secret containing the
							// STS(Security Token Service) Token.
							token?: {
								// A key in the referenced Secret.
								// Some instances of this field may be defaulted, in others it may
								// be required.
								key?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"

								// The name of the Secret resource being referred to.
								name?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// The namespace of the Secret resource being referred to.
								// Ignored if referent is not cluster-scoped, otherwise defaults
								// to the namespace of the referent.
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
							}
						}
					}

					// Region specifies the Volcengine region to connect to.
					region!: string
				}

				// Webhook configures this store to sync secrets using a generic
				// templated webhook
				webhook?: {
					// Auth specifies a authorization protocol. Only one protocol may
					// be set.
					auth?: struct.MinFields(
						1) & struct.MaxFields(
						1) & {
							// NTLMProtocol configures the store to use NTLM for auth
							ntlm?: {
								// A reference to a specific 'key' within a Secret resource.
								// In some instances, `key` is a required field.
								passwordSecret!: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}

								// A reference to a specific 'key' within a Secret resource.
								// In some instances, `key` is a required field.
								usernameSecret!: {
									// A key in the referenced Secret.
									// Some instances of this field may be defaulted, in others it may
									// be required.
									key?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[-._a-zA-Z0-9]+$"

									// The name of the Secret resource being referred to.
									name?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// The namespace of the Secret resource being referred to.
									// Ignored if referent is not cluster-scoped, otherwise defaults
									// to the namespace of the referent.
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
								}
							}
						}

					// Body
					body?: string

					// PEM encoded CA bundle used to validate webhook server
					// certificate. Only used
					// if the Server URL is using HTTPS protocol. This parameter is
					// ignored for
					// plain HTTP protocol connection. If not set the system root
					// certificates
					// are used to validate the TLS connection.
					caBundle?: string

					// The provider for the CA bundle to use to validate webhook
					// server certificate.
					caProvider?: {
						// The key where the CA certificate can be found in the Secret or
						// ConfigMap.
						key?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[-._a-zA-Z0-9]+$"

						// The name of the object located at the provider type.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// The namespace the Provider type is in.
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// The type of provider to use such as "Secret", or "ConfigMap".
						type!: "Secret" | "ConfigMap"
					}

					// Headers
					headers?: [string]: string

					// Webhook Method
					method?: string

					// Result formatting
					result!: {
						// Json path of return value
						jsonPath?: string
					}

					// Secrets to fill in templates
					// These secrets will be passed to the templating function as key
					// value pairs under the given name
					secrets?: [...{
						// Name of this secret in templates
						name!: string

						// Secret ref to fill in credentials
						secretRef!: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}]

					// Timeout
					timeout?: string

					// Webhook url to call
					url!: string
				}

				// YandexCertificateManager configures this store to sync secrets
				// using Yandex Certificate Manager provider
				yandexcertificatemanager?: {
					// Yandex.Cloud API endpoint (e.g. 'api.cloud.yandex.net:443')
					apiEndpoint?: string

					// Auth defines the information necessary to authenticate against
					// Yandex.Cloud
					auth!: {
						// The authorized key used for authentication
						authorizedKeySecretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// The provider for the CA bundle to use to validate Yandex.Cloud
					// server certificate.
					caProvider?: {
						// A reference to a specific 'key' within a Secret resource.
						// In some instances, `key` is a required field.
						certSecretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// FetchingPolicy configures the provider to interpret the
					// `data.secretKey.remoteRef.key` field in ExternalSecret as
					// certificate ID or certificate name
					fetching?: struct.MinFields(
						1) & struct.MaxFields(
						1) & {
							// ByID configures the provider to interpret the
							// `data.secretKey.remoteRef.key` field in ExternalSecret as
							// secret ID.
							byID?: {}

							// ByName configures the provider to interpret the
							// `data.secretKey.remoteRef.key` field in ExternalSecret as
							// secret name.
							byName?: {
								// The folder to fetch secrets from
								folderID!: string
							}
						}
				}

				// YandexLockbox configures this store to sync secrets using
				// Yandex Lockbox provider
				yandexlockbox?: {
					// Yandex.Cloud API endpoint (e.g. 'api.cloud.yandex.net:443')
					apiEndpoint?: string

					// Auth defines the information necessary to authenticate against
					// Yandex.Cloud
					auth!: {
						// The authorized key used for authentication
						authorizedKeySecretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// The provider for the CA bundle to use to validate Yandex.Cloud
					// server certificate.
					caProvider?: {
						// A reference to a specific 'key' within a Secret resource.
						// In some instances, `key` is a required field.
						certSecretRef?: {
							// A key in the referenced Secret.
							// Some instances of this field may be defaulted, in others it may
							// be required.
							key?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[-._a-zA-Z0-9]+$"

							// The name of the Secret resource being referred to.
							name?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// The namespace of the Secret resource being referred to.
							// Ignored if referent is not cluster-scoped, otherwise defaults
							// to the namespace of the referent.
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
						}
					}

					// FetchingPolicy configures the provider to interpret the
					// `data.secretKey.remoteRef.key` field in ExternalSecret as
					// secret ID or secret name
					fetching?: struct.MinFields(
						1) & struct.MaxFields(
						1) & {
							// ByID configures the provider to interpret the
							// `data.secretKey.remoteRef.key` field in ExternalSecret as
							// secret ID.
							byID?: {}

							// ByName configures the provider to interpret the
							// `data.secretKey.remoteRef.key` field in ExternalSecret as
							// secret name.
							byName?: {
								// The folder to fetch secrets from
								folderID!: string
							}
						}
				}
			}

		// Used to configure store refresh interval in seconds. Empty or 0
		// will default to the controller config.
		refreshInterval?: int

		// Used to configure http retries if failed
		retrySettings?: {
			maxRetries?:    int32 & int
			retryInterval?: string
		}
	}

	// SecretStoreStatus defines the observed state of the
	// SecretStore.
	status?: {
		// SecretStoreCapabilities defines the possible operations a
		// SecretStore can do.
		capabilities?: string
		conditions?: [...{
			lastTransitionTime?: time.Time
			message?:            string
			reason?:             string
			status!:             string
			type!:               string
		}]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "external-secrets.io/v1"
	kind:       "SecretStore"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}

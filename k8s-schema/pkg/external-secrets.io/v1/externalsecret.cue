package v1

import (
	"strings"
	"struct"
	"time"
)

#ExternalSecret: {
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

	// ExternalSecretSpec defines the desired state of ExternalSecret.
	spec?: {
		// Data defines the connection between the Kubernetes Secret keys
		// and the Provider data
		data?: [...{
			// RemoteRef points to the remote secret and defines
			// which secret (version/property/..) to fetch.
			remoteRef!: {
				// Used to define a conversion Strategy
				conversionStrategy?: "Default" | "Unicode"

				// Used to define a decoding Strategy
				decodingStrategy?: "Auto" | "Base64" | "Base64URL" | "None"

				// Key is the key used in the Provider, mandatory
				key!: string

				// Policy for fetching tags/labels from provider secrets, possible
				// options are Fetch, None. Defaults to None
				metadataPolicy?: "None" | "Fetch"

				// Used to select a specific property of the Provider value (if a
				// map), if supported
				property?: string

				// Used to select a specific version of the Provider value, if
				// supported
				version?: string
			}

			// The key in the Kubernetes Secret to store the value.
			secretKey!: strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^[-._a-zA-Z0-9]+$"

			// SourceRef allows you to override the source
			// from which the value will be pulled.
			sourceRef?: struct.MinFields(
				1) & struct.MaxFields(
				1) & {
					// GeneratorRef points to a generator custom resource.
					//
					// Deprecated: The generatorRef is not implemented in .data[].
					// this will be removed with v1.
					generatorRef?: {
						// Specify the apiVersion of the generator resource
						apiVersion?: string

						// Specify the Kind of the generator resource
						kind!: "ACRAccessToken" | "ClusterGenerator" | "CloudsmithAccessToken" | "ECRAuthorizationToken" | "Fake" | "GCRAccessToken" | "GithubAccessToken" | "QuayAccessToken" | "Password" | "SSHKey" | "STSSessionToken" | "UUID" | "VaultDynamicSecret" | "Webhook" | "Grafana" | "MFA"

						// Specify the name of the generator resource
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}

					// SecretStoreRef defines which SecretStore to fetch the
					// ExternalSecret data.
					storeRef?: {
						// Kind of the SecretStore resource (SecretStore or
						// ClusterSecretStore)
						// Defaults to `SecretStore`
						kind?: "SecretStore" | "ClusterSecretStore"

						// Name of the SecretStore resource
						name?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
				}
		}]

		// DataFrom is used to fetch all properties from a specific
		// Provider data
		// If multiple entries are specified, the Secret keys are merged
		// in the specified order
		dataFrom?: [...{
			// Used to extract multiple key/value pairs from one secret
			// Note: Extract does not support sourceRef.Generator or
			// sourceRef.GeneratorRef.
			extract?: {
				// Used to define a conversion Strategy
				conversionStrategy?: "Default" | "Unicode"

				// Used to define a decoding Strategy
				decodingStrategy?: "Auto" | "Base64" | "Base64URL" | "None"

				// Key is the key used in the Provider, mandatory
				key!: string

				// Policy for fetching tags/labels from provider secrets, possible
				// options are Fetch, None. Defaults to None
				metadataPolicy?: "None" | "Fetch"

				// Used to select a specific property of the Provider value (if a
				// map), if supported
				property?: string

				// Used to select a specific version of the Provider value, if
				// supported
				version?: string
			}

			// Used to find secrets based on tags or regular expressions
			// Note: Find does not support sourceRef.Generator or
			// sourceRef.GeneratorRef.
			find?: {
				// Used to define a conversion Strategy
				conversionStrategy?: "Default" | "Unicode"

				// Used to define a decoding Strategy
				decodingStrategy?: "Auto" | "Base64" | "Base64URL" | "None"

				// Finds secrets based on the name.
				name?: {
					// Finds secrets base
					regexp?: string
				}

				// A root path to start the find operations.
				path?: string

				// Find secrets based on tags.
				tags?: [string]: string
			}

			// Used to rewrite secret Keys after getting them from the secret
			// Provider
			// Multiple Rewrite operations can be provided. They are applied
			// in a layered order (first to last)
			rewrite?: [...struct.MinFields(
				1) & struct.MaxFields(
				1) & {
					// Used to merge key/values in one single Secret
					// The resulting key will contain all values from the specified
					// secrets
					merge?: {
						// Used to define the policy to use in conflict resolution.
						conflictPolicy?: "Ignore" | "Error"

						// Used to define the target key of the merge operation.
						// Required if strategy is JSON. Ignored otherwise.
						into?: string

						// Used to define key priority in conflict resolution.
						priority?: [...string]

						// Used to define the policy when a key in the priority list does
						// not exist in the input.
						priorityPolicy?: "IgnoreNotFound" | "Strict"

						// Used to define the strategy to use in the merge operation.
						strategy?: "Extract" | "JSON"
					}

					// Used to rewrite with regular expressions.
					// The resulting key will be the output of a regexp.ReplaceAll
					// operation.
					regexp?: {
						// Used to define the regular expression of a re.Compiler.
						source!: string

						// Used to define the target pattern of a ReplaceAll operation.
						target!: string
					}

					// Used to apply string transformation on the secrets.
					// The resulting key will be the output of the template applied by
					// the operation.
					transform?: {
						// Used to define the template to apply on the secret name.
						// `.value ` will specify the secret name in the template.
						template!: string
					}
				}]

			// SourceRef points to a store or generator
			// which contains secret values ready to use.
			// Use this in combination with Extract or Find pull values out of
			// a specific SecretStore.
			// When sourceRef points to a generator Extract or Find is not
			// supported.
			// The generator returns a static map of values
			sourceRef?: struct.MinFields(
				1) & struct.MaxFields(
				1) & {
					// GeneratorRef points to a generator custom resource.
					generatorRef?: {
						// Specify the apiVersion of the generator resource
						apiVersion?: string

						// Specify the Kind of the generator resource
						kind!: "ACRAccessToken" | "ClusterGenerator" | "CloudsmithAccessToken" | "ECRAuthorizationToken" | "Fake" | "GCRAccessToken" | "GithubAccessToken" | "QuayAccessToken" | "Password" | "SSHKey" | "STSSessionToken" | "UUID" | "VaultDynamicSecret" | "Webhook" | "Grafana" | "MFA"

						// Specify the name of the generator resource
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}

					// SecretStoreRef defines which SecretStore to fetch the
					// ExternalSecret data.
					storeRef?: {
						// Kind of the SecretStore resource (SecretStore or
						// ClusterSecretStore)
						// Defaults to `SecretStore`
						kind?: "SecretStore" | "ClusterSecretStore"

						// Name of the SecretStore resource
						name?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
				}
		}]

		// RefreshInterval is the amount of time before the values are
		// read again from the SecretStore provider,
		// specified as Golang Duration strings.
		// Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h"
		// Example values: "1h", "2h30m", "10s"
		// May be set to zero to fetch and create it once. Defaults to 1h.
		refreshInterval?: string

		// RefreshPolicy determines how the ExternalSecret should be
		// refreshed:
		// - CreatedOnce: Creates the Secret only if it does not exist and
		// does not update it thereafter
		// - Periodic: Synchronizes the Secret from the external source at
		// regular intervals specified by refreshInterval.
		// No periodic updates occur if refreshInterval is 0.
		// - OnChange: Only synchronizes the Secret when the
		// ExternalSecret's metadata or specification changes
		refreshPolicy?: "CreatedOnce" | "Periodic" | "OnChange"

		// SecretStoreRef defines which SecretStore to fetch the
		// ExternalSecret data.
		secretStoreRef?: {
			// Kind of the SecretStore resource (SecretStore or
			// ClusterSecretStore)
			// Defaults to `SecretStore`
			kind?: "SecretStore" | "ClusterSecretStore"

			// Name of the SecretStore resource
			name?: strings.MaxRunes(
				253) & strings.MinRunes(
				1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}

		// ExternalSecretTarget defines the Kubernetes Secret to be
		// created
		// There can be only one target per ExternalSecret.
		target?: {
			// CreationPolicy defines rules on how to create the resulting
			// Secret.
			// Defaults to "Owner"
			creationPolicy?: "Owner" | "Orphan" | "Merge" | "None"

			// DeletionPolicy defines rules on how to delete the resulting
			// Secret.
			// Defaults to "Retain"
			deletionPolicy?: "Delete" | "Merge" | "Retain"

			// Immutable defines if the final secret will be immutable
			immutable?: bool

			// The name of the Secret resource to be managed.
			// Defaults to the .metadata.name of the ExternalSecret resource
			name?: strings.MaxRunes(
				253) & strings.MinRunes(
				1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Template defines a blueprint for the created Secret resource.
			template?: {
				data?: [string]: string

				// EngineVersion specifies the template engine version
				// that should be used to compile/execute the
				// template specified in .data and .templateFrom[].
				engineVersion?: "v2"
				mergePolicy?:   "Replace" | "Merge"

				// ExternalSecretTemplateMetadata defines metadata fields for the
				// Secret blueprint.
				metadata?: {
					annotations?: [string]: string
					finalizers?: [...string]
					labels?: [string]: string
				}
				templateFrom?: [...{
					configMap?: {
						// A list of keys in the ConfigMap/Secret to use as templates for
						// Secret data
						items!: [...{
							// A key in the ConfigMap/Secret
							key!:        strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"
							templateAs?: "Values" | "KeysAndValues"
						}]

						// The name of the ConfigMap/Secret resource
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
					literal?: string
					secret?: {
						// A list of keys in the ConfigMap/Secret to use as templates for
						// Secret data
						items!: [...{
							// A key in the ConfigMap/Secret
							key!:        strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[-._a-zA-Z0-9]+$"
							templateAs?: "Values" | "KeysAndValues"
						}]

						// The name of the ConfigMap/Secret resource
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
					target?: "Data" | "Annotations" | "Labels"
				}]
				type?: string
			}
		}
	}
	status?: {
		// Binding represents a servicebinding.io Provisioned Service
		// reference to the secret
		binding?: {
			// Name of the referent.
			// This field is effectively required, but due to backwards
			// compatibility is
			// allowed to be empty. Instances of this type with an empty value
			// here are
			// almost certainly wrong.
			// More info:
			// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
			name?: string
		}
		conditions?: [...{
			lastTransitionTime?: time.Time
			message?:            string
			reason?:             string
			status!:             string
			type!:               "Ready" | "Deleted"
		}]

		// refreshTime is the time and date the external secret was
		// fetched and
		// the target secret updated
		refreshTime?:
			null | time.Time

		// SyncedResourceVersion keeps track of the last synced version
		syncedResourceVersion?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "external-secrets.io/v1"
	kind:       "ExternalSecret"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}

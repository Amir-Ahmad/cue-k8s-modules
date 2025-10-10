package v1

import (
	"struct"
	"strings"
	"list"
	"time"
)

#BackendTLSPolicy: {
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

	// Spec defines the desired state of BackendTLSPolicy.
	spec!: {
		// Options are a list of key/value pairs to enable extended TLS
		// configuration for each implementation. For example, configuring
		// the
		// minimum TLS version or supported cipher suites.
		//
		// A set of common keys MAY be defined by the API in the future.
		// To avoid
		// any ambiguity, implementation-specific definitions MUST use
		// domain-prefixed names, such as `example.com/my-custom-option`.
		// Un-prefixed names are reserved for key names defined by Gateway
		// API.
		//
		// Support: Implementation-specific
		options?: struct.MaxFields(
			16) & {
				[string]: strings.MaxRunes(
						4096) & strings.MinRunes(
						0)
			}

		// TargetRefs identifies an API object to apply the policy to.
		// Only Services have Extended support. Implementations MAY
		// support
		// additional objects, with Implementation Specific support.
		// Note that this config applies to the entire referenced resource
		// by default, but this default may change in the future to
		// provide
		// a more granular application of the policy.
		//
		// TargetRefs must be _distinct_. This means either that:
		//
		// * They select different targets. If this is the case, then
		// targetRef
		// entries are distinct. In terms of fields, this means that the
		// multi-part key defined by `group`, `kind`, and `name` must
		// be unique across all targetRef entries in the BackendTLSPolicy.
		// * They select different sectionNames in the same target.
		//
		// When more than one BackendTLSPolicy selects the same target and
		// sectionName, implementations MUST determine precedence using
		// the
		// following criteria, continuing on ties:
		//
		// * The older policy by creation timestamp takes precedence. For
		// example, a policy with a creation timestamp of "2021-07-15
		// 01:02:03" MUST be given precedence over a policy with a
		// creation timestamp of "2021-07-15 01:02:04".
		// * The policy appearing first in alphabetical order by {name}.
		// For example, a policy named `bar` is given precedence over a
		// policy named `baz`.
		//
		// For any BackendTLSPolicy that does not take precedence, the
		// implementation MUST ensure the `Accepted` Condition is set to
		// `status: False`, with Reason `Conflicted`.
		//
		// Support: Extended for Kubernetes Service
		//
		// Support: Implementation-specific for any other resource
		targetRefs!: list.MaxItems(16) & [...{
			// Group is the group of the target resource.
			group!: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Kind is kind of the target resource.
			kind!: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// Name is the name of the target resource.
			name!: strings.MaxRunes(
				253) & strings.MinRunes(
				1)

			// SectionName is the name of a section within the target
			// resource. When
			// unspecified, this targetRef targets the entire resource. In the
			// following
			// resources, SectionName is interpreted as the following:
			//
			// * Gateway: Listener name
			// * HTTPRoute: HTTPRouteRule name
			// * Service: Port name
			//
			// If a SectionName is specified, but does not exist on the
			// targeted object,
			// the Policy must fail to attach, and the policy implementation
			// should record
			// a `ResolvedRefs` or similar Condition in the Policy's status.
			sectionName?: strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}] & [_, ...]

		// Validation contains backend TLS validation configuration.
		validation!: {
			// CACertificateRefs contains one or more references to Kubernetes
			// objects that
			// contain a PEM-encoded TLS CA certificate bundle, which is used
			// to
			// validate a TLS handshake between the Gateway and backend Pod.
			//
			// If CACertificateRefs is empty or unspecified, then
			// WellKnownCACertificates must be
			// specified. Only one of CACertificateRefs or
			// WellKnownCACertificates may be specified,
			// not both. If CACertificateRefs is empty or unspecified, the
			// configuration for
			// WellKnownCACertificates MUST be honored instead if supported by
			// the implementation.
			//
			// A CACertificateRef is invalid if:
			//
			// * It refers to a resource that cannot be resolved (e.g., the
			// referenced resource
			// does not exist) or is misconfigured (e.g., a ConfigMap does not
			// contain a key
			// named `ca.crt`). In this case, the Reason must be set to
			// `InvalidCACertificateRef`
			// and the Message of the Condition must indicate which reference
			// is invalid and why.
			//
			// * It refers to an unknown or unsupported kind of resource. In
			// this case, the Reason
			// must be set to `InvalidKind` and the Message of the Condition
			// must explain which
			// kind of resource is unknown or unsupported.
			//
			// * It refers to a resource in another namespace. This may change
			// in future
			// spec updates.
			//
			// Implementations MAY choose to perform further validation of the
			// certificate
			// content (e.g., checking expiry or enforcing specific formats).
			// In such cases,
			// an implementation-specific Reason and Message must be set for
			// the invalid reference.
			//
			// In all cases, the implementation MUST ensure the `ResolvedRefs`
			// Condition on
			// the BackendTLSPolicy is set to `status: False`, with a Reason
			// and Message
			// that indicate the cause of the error. Connections using an
			// invalid
			// CACertificateRef MUST fail, and the client MUST receive an HTTP
			// 5xx error
			// response. If ALL CACertificateRefs are invalid, the
			// implementation MUST also
			// ensure the `Accepted` Condition on the BackendTLSPolicy is set
			// to
			// `status: False`, with a Reason `NoValidCACertificate`.
			//
			// A single CACertificateRef to a Kubernetes ConfigMap kind has
			// "Core" support.
			// Implementations MAY choose to support attaching multiple
			// certificates to
			// a backend, but this behavior is implementation-specific.
			//
			// Support: Core - An optional single reference to a Kubernetes
			// ConfigMap,
			// with the CA certificate in a key named `ca.crt`.
			//
			// Support: Implementation-specific - More than one reference,
			// other kinds
			// of resources, or a single reference that includes multiple
			// certificates.
			caCertificateRefs?: list.MaxItems(8) & [...{
				// Group is the group of the referent. For example,
				// "gateway.networking.k8s.io".
				// When unspecified or empty string, core API group is inferred.
				group!: strings.MaxRunes(
					253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

				// Kind is kind of the referent. For example "HTTPRoute" or
				// "Service".
				kind!: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

				// Name is the name of the referent.
				name!: strings.MaxRunes(
					253) & strings.MinRunes(
					1)
			}]

			// Hostname is used for two purposes in the connection between
			// Gateways and
			// backends:
			//
			// 1. Hostname MUST be used as the SNI to connect to the backend
			// (RFC 6066).
			// 2. Hostname MUST be used for authentication and MUST match the
			// certificate
			// served by the matching backend, unless SubjectAltNames is
			// specified.
			// 3. If SubjectAltNames are specified, Hostname can be used for
			// certificate selection
			// but MUST NOT be used for authentication. If you want to use the
			// value
			// of the Hostname field for authentication, you MUST add it to
			// the SubjectAltNames list.
			//
			// Support: Core
			hostname!: strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// SubjectAltNames contains one or more Subject Alternative Names.
			// When specified the certificate served from the backend MUST
			// have at least one Subject Alternate Name matching one of the
			// specified SubjectAltNames.
			//
			// Support: Extended
			subjectAltNames?: list.MaxItems(5) & [...{
				// Hostname contains Subject Alternative Name specified in DNS
				// name format.
				// Required when Type is set to Hostname, ignored otherwise.
				//
				// Support: Core
				hostname?: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

				// Type determines the format of the Subject Alternative Name.
				// Always required.
				//
				// Support: Core
				type!: "Hostname" | "URI"

				// URI contains Subject Alternative Name specified in a full URI
				// format.
				// It MUST include both a scheme (e.g., "http" or "ftp") and a
				// scheme-specific-part.
				// Common values include SPIFFE IDs like
				// "spiffe://mycluster.example.com/ns/myns/sa/svc1sa".
				// Required when Type is set to URI, ignored otherwise.
				//
				// Support: Core
				uri?: strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^(([^:/?#]+):)(//([^/?#]*))([^?#]*)(\\?([^#]*))?(#(.*))?"
			}]

			// WellKnownCACertificates specifies whether system CA
			// certificates may be used in
			// the TLS handshake between the gateway and backend pod.
			//
			// If WellKnownCACertificates is unspecified or empty (""), then
			// CACertificateRefs
			// must be specified with at least one entry for a valid
			// configuration. Only one of
			// CACertificateRefs or WellKnownCACertificates may be specified,
			// not both.
			// If an implementation does not support the
			// WellKnownCACertificates field, or
			// the supplied value is not recognized, the implementation MUST
			// ensure the
			// `Accepted` Condition on the BackendTLSPolicy is set to `status:
			// False`, with
			// a Reason `Invalid`.
			//
			// Support: Implementation-specific
			wellKnownCACertificates?: "System"
		}
	}

	// Status defines the current state of BackendTLSPolicy.
	status?: {
		// Ancestors is a list of ancestor resources (usually Gateways)
		// that are
		// associated with the policy, and the status of the policy with
		// respect to
		// each ancestor. When this policy attaches to a parent, the
		// controller that
		// manages the parent and the ancestors MUST add an entry to this
		// list when
		// the controller first sees the policy and SHOULD update the
		// entry as
		// appropriate when the relevant ancestor is modified.
		//
		// Note that choosing the relevant ancestor is left to the Policy
		// designers;
		// an important part of Policy design is designing the right
		// object level at
		// which to namespace this status.
		//
		// Note also that implementations MUST ONLY populate ancestor
		// status for
		// the Ancestor resources they are responsible for.
		// Implementations MUST
		// use the ControllerName field to uniquely identify the entries
		// in this list
		// that they are responsible for.
		//
		// Note that to achieve this, the list of PolicyAncestorStatus
		// structs
		// MUST be treated as a map with a composite key, made up of the
		// AncestorRef
		// and ControllerName fields combined.
		//
		// A maximum of 16 ancestors will be represented in this list. An
		// empty list
		// means the Policy is not relevant for any ancestors.
		//
		// If this slice is full, implementations MUST NOT add further
		// entries.
		// Instead they MUST consider the policy unimplementable and
		// signal that
		// on any related resources such as the ancestor that would be
		// referenced
		// here. For example, if this list was full on BackendTLSPolicy,
		// no
		// additional Gateways would be able to reference the Service
		// targeted by
		// the BackendTLSPolicy.
		ancestors!: list.MaxItems(16) & [...{
			// AncestorRef corresponds with a ParentRef in the spec that this
			// PolicyAncestorStatus struct describes the status of.
			ancestorRef!: {
				// Group is the group of the referent.
				// When unspecified, "gateway.networking.k8s.io" is inferred.
				// To set the core API group (such as for a "Service" kind
				// referent),
				// Group must be explicitly set to "" (empty string).
				//
				// Support: Core
				group?: strings.MaxRunes(
					253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

				// Kind is kind of the referent.
				//
				// There are two kinds of parent resources with "Core" support:
				//
				// * Gateway (Gateway conformance profile)
				// * Service (Mesh conformance profile, ClusterIP Services only)
				//
				// Support for other resources is Implementation-Specific.
				kind?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

				// Name is the name of the referent.
				//
				// Support: Core
				name!: strings.MaxRunes(
					253) & strings.MinRunes(
					1)

				// Namespace is the namespace of the referent. When unspecified,
				// this refers
				// to the local namespace of the Route.
				//
				// Note that there are specific rules for ParentRefs which cross
				// namespace
				// boundaries. Cross-namespace references are only valid if they
				// are explicitly
				// allowed by something in the namespace they are referring to.
				// For example:
				// Gateway has the AllowedRoutes field, and ReferenceGrant
				// provides a
				// generic way to enable any other kind of cross-namespace
				// reference.
				//
				// Support: Core
				namespace?: strings.MaxRunes(
						63) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

				// Port is the network port this Route targets. It can be
				// interpreted
				// differently based on the type of parent resource.
				//
				// When the parent resource is a Gateway, this targets all
				// listeners
				// listening on the specified port that also support this kind of
				// Route(and
				// select this Route). It's not recommended to set `Port` unless
				// the
				// networking behaviors specified in a Route must apply to a
				// specific port
				// as opposed to a listener(s) whose port(s) may be changed. When
				// both Port
				// and SectionName are specified, the name and port of the
				// selected listener
				// must match both specified values.
				//
				// Implementations MAY choose to support other parent resources.
				// Implementations supporting other types of parent resources MUST
				// clearly
				// document how/if Port is interpreted.
				//
				// For the purpose of status, an attachment is considered
				// successful as
				// long as the parent resource accepts it partially. For example,
				// Gateway
				// listeners can restrict which Routes can attach to them by Route
				// kind,
				// namespace, or hostname. If 1 of 2 Gateway listeners accept
				// attachment
				// from the referencing Route, the Route MUST be considered
				// successfully
				// attached. If no Gateway listeners accept attachment from this
				// Route,
				// the Route MUST be considered detached from the Gateway.
				//
				// Support: Extended
				port?: int32 & int & <=65535 & >=1

				// SectionName is the name of a section within the target
				// resource. In the
				// following resources, SectionName is interpreted as the
				// following:
				//
				// * Gateway: Listener name. When both Port (experimental) and
				// SectionName
				// are specified, the name and port of the selected listener must
				// match
				// both specified values.
				// * Service: Port name. When both Port (experimental) and
				// SectionName
				// are specified, the name and port of the selected listener must
				// match
				// both specified values.
				//
				// Implementations MAY choose to support attaching Routes to other
				// resources.
				// If that is the case, they MUST clearly document how SectionName
				// is
				// interpreted.
				//
				// When unspecified (empty string), this will reference the entire
				// resource.
				// For the purpose of status, an attachment is considered
				// successful if at
				// least one section in the parent resource accepts it. For
				// example, Gateway
				// listeners can restrict which Routes can attach to them by Route
				// kind,
				// namespace, or hostname. If 1 of 2 Gateway listeners accept
				// attachment from
				// the referencing Route, the Route MUST be considered
				// successfully
				// attached. If no Gateway listeners accept attachment from this
				// Route, the
				// Route MUST be considered detached from the Gateway.
				//
				// Support: Core
				sectionName?: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
			}

			// Conditions describes the status of the Policy with respect to
			// the given Ancestor.
			conditions!: list.MaxItems(8) & [...{
				// lastTransitionTime is the last time the condition transitioned
				// from one status to another.
				// This should be when the underlying condition changed. If that
				// is not known, then using the time when the API field changed
				// is acceptable.
				lastTransitionTime!: time.Time

				// message is a human readable message indicating details about
				// the transition.
				// This may be an empty string.
				message!: strings.MaxRunes(
						32768)

				// observedGeneration represents the .metadata.generation that the
				// condition was set based upon.
				// For instance, if .metadata.generation is currently 12, but the
				// .status.conditions[x].observedGeneration is 9, the condition
				// is out of date
				// with respect to the current state of the instance.
				observedGeneration?: int64 & int & >=0

				// reason contains a programmatic identifier indicating the reason
				// for the condition's last transition.
				// Producers of specific condition types may define expected
				// values and meanings for this field,
				// and whether the values are considered a guaranteed API.
				// The value should be a CamelCase string.
				// This field may not be empty.
				reason!: strings.MaxRunes(
						1024) & strings.MinRunes(
						1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"

				// status of the condition, one of True, False, Unknown.
				status!: "True" | "False" | "Unknown"

				// type of condition in CamelCase or in foo.example.com/CamelCase.
				type!: strings.MaxRunes(
					316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
			}] & [_, ...]

			// ControllerName is a domain/path string that indicates the name
			// of the
			// controller that wrote this status. This corresponds with the
			// controllerName field on GatewayClass.
			//
			// Example: "example.net/gateway-controller".
			//
			// The format of this field is DOMAIN "/" PATH, where DOMAIN and
			// PATH are
			// valid Kubernetes names
			// (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
			//
			// Controllers MUST populate this field when writing status.
			// Controllers should ensure that
			// entries to status populated with their ControllerName are
			// cleaned up when they are no
			// longer necessary.
			controllerName!: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
		}]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "BackendTLSPolicy"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}

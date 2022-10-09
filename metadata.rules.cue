#Spec: {
	app:  #NonEmptyString
	base: bool
	channels: [...#Channels]
}

#Channels: {
	name: #NonEmptyString
	platforms: [...#AcceptedPlatforms]
	stable: bool
	tests: {
		enabled: bool
		type?:   =~"^(cli|web)$"
		dgoss_args?: string
	}
}

#NonEmptyString:           string & !=""
#AcceptedPlatforms:        "linux/amd64" | "linux/arm64"

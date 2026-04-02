package picoclaw

import "embed"

// EmbeddedWorkspace contains the default onboarding templates copied into a new
// PicoClaw home. Keeping the source of truth at the repository root avoids
// generated, ignored copies that break clean-environment builds.
//
//go:embed workspace/**
var EmbeddedWorkspace embed.FS

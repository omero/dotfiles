---
name: component-architecture
description: "Apply an opinionated component architecture on top of the building-components skill: composable slots, constrained styleTweaks, root-owned styling state, and small stable APIs. Use when reviewing, designing, or implementing reusable UI components."
---

# Component Architecture Policy

This skill **extends** `building-components`; it does not replace it.

## Required base skill

Before beginning component work, load and follow the available
`building-components` skill.

Use it for the implementation details:
- accessibility and semantic HTML
- composable APIs and slots
- TypeScript component typing
- `asChild` and polymorphism
- data attributes and styling
- design tokens
- component documentation and distribution

If it is unavailable, state that briefly and still apply this policy.

## Architectural policy

Use these rules to make the component API intentionally flexible without
becoming page-specific or unbounded.

```text
Component owns:
  semantic structure
  named slots
  approved visual modes
  responsive behavior
  defaults and shared styling state

Caller owns:
  content and slot composition
  destinations and callbacks
  ARIA labels and IDs
  normal native-element props
  small local className adjustments
```

### Guardrail 1: slots for content structure

Prefer meaningful compound slots over content-fragment props.

```tsx
<Component>
  <Component.Container>
    <Component.Content />
    <Component.Actions />
    <Component.Media />
  </Component.Container>
</Component>
```

Do not add content related props like `title`, `description`, `image`, `primaryAction`,
when caller composition is clearer.

### Guardrail 2: `styleTweaks` for approved visual choices

Use a small object of closed union types. Every option must be:
- reusable across multiple consumers
- visually distinct
- independently understandable
- supported by a default

```ts
type ComponentStyleTweaks = {
  layout?: "split" | "stacked" | "overlay";
  surface?: "default" | "muted" | "accent";
  spacing?: "compact" | "default" | "spacious";
};
```

Avoid arbitrary values, page-specific options, and accumulating booleans.

### Guardrail 3: root-owned visual state

Resolve `styleTweaks` defaults once at the root and expose the result through
`data-*` attributes. Slots respond via CSS selectors; do not prop-drill visual
state merely to style descendants.

```tsx
<Component
  data-layout={layout}
  data-surface={surface}
  data-spacing={spacing}
/>
```

### Guardrail 4: resist API growth

Before adding a prop, decide:

```text
Is it content?              → caller composes a slot
Is it an approved visual?   → add a closed styleTweaks option
Is it a native behavior?    → forward the native prop
Is it consumer-specific?    → caller handles it outside the primitive
```

Do not expand the primitive for a single page unless there is a demonstrated
reusable need.

## Workflow

1. Load `building-components`.
2. Inspect the target, direct consumers, and existing design primitives.
3. State the component/caller ownership boundary.
4. Propose the smallest API consistent with this policy.
5. Implement only the requested change.
6. Validate the smallest relevant surface.

## Response format

Include:

1. The smallest useful component tree or flow diagram.
2. **Component owns**, **Caller owns**, and **Approved styleTweaks**.
3. Any API additions explicitly rejected, with a short reason.
4. Changed paths and validation performed.

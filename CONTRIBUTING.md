# Guide to Contributing

This book is developed collaboratively and openly, here on GitHub. We accept comments, contributions, and corrections from all.

## Current Project Status

**PRE-FIRST EDITION (CALL FOR REVIEWERS)**

We are actively seeking expert reviewers and contributors to help refine the content before the official first edition release.

## Why Contribute

This is an open-source effort to create the definitive advanced resource for understanding crypto markets, infrastructure, and risk. By contributing, you are helping raise the bar for how the industry educates its next generation of participants and builders.

If your contribution is accepted, whether it's a technical correction, a new example, or a meaningful improvement to an explanation, **you will be credited as a reviewer in the published edition of the book**. This is a permanent acknowledgment of your expertise and your role in shaping the final text.

We believe the best way to move this industry forward is through open, rigorous, and collaborative knowledge sharing, and every meaningful contribution helps make that happen.

## License and Attribution

All contributions must be properly licensed and attributed. If you are contributing your own original work, then you are offering it under a **CC-BY license** (Creative Commons Attribution). You are responsible for adding your own name or pseudonym in the acknowledgments, as attribution for your contribution.

If you are sourcing a contribution from somewhere else, it must carry a compatible license. The book will initially be released under a **CC-BY-NC-ND license**, which means that contributions must be licensed under open licenses such as MIT, CC0, CC-BY, etc. You need to indicate the original source and original license by including a markdown comment above your contribution, like this:

```markdown
<!--
Source: https://example.com/originaltext
License: CC0
Added by: @yourusername
-->
```

## Contributing with a Pull Request

The best way to contribute to this book is by making a pull request:

1. **Login** with your GitHub account or create one now
2. **Fork** this repository. Work on your fork.
3. **Create a new branch** on which to make your change, e.g., `git checkout -b my_contribution`, or make the change on the `develop` branch.
4. **One PR per file** - Please do one pull request per markdown file to avoid large merges.
5. **Edit the markdown file** where you want to make a change.
6. **Attribution** - If you want attribution for your contribution, note your GitHub username or pseudonym in the pull request description. Significant contributors will be acknowledged in future editions.
7. **Commit your change** - Include a commit message describing the correction.
8. **Submit a pull request** against this repository.

### What to Contribute

We especially welcome:

- **Technical corrections** - Errors in how protocols, mechanisms, or concepts are described
- **Outdated information** - Crypto moves fast; help us keep the content current
- **Clarity improvements** - Better explanations of complex topics
- **Missing context** - Important caveats or considerations we may have overlooked
- **Code examples** - Corrections to any code snippets or technical examples

### What Not to Submit

Please avoid submitting PRs for:

- Minor typos or grammar issues (these will be handled during copy editing)
- Stylistic preferences that don't improve clarity
- Adding promotional content or links

## Contributing with an Issue

If you find a mistake and you're not sure how to fix it, or you don't know how to do a pull request, then you can file an **Issue**. Filing an Issue will help us see the problem and fix it.

When filing an issue, please include:

- The chapter and section where the issue appears
- A clear description of the problem
- If applicable, what you believe the correct information should be
- Any sources that support the correction

## Technical Guidelines

### Line Endings

All submissions should use Unix-like line endings: **LF** (not CR, not CR/LF). Incorrect line endings, or changes to line endings, cause confusion for the diff tools and make the whole file look like it has changed.

If you are unsure or your OS makes things difficult, consider using a developer's text editor such as VSCode.

### Markdown Formatting

- Use standard GitHub-flavored Markdown
- Maintain consistent heading hierarchy (# for chapter title, ## for sections, ### for subsections)
- Use **bold** for key terms when first introduced
- Use `code formatting` for technical terms, addresses, function names, etc.
- Keep lines at a reasonable length for readability in diffs

### Commit Messages

Write clear, descriptive commit messages:

```
Good: "Fix incorrect explanation of ECDSA nonce generation in ch05_custody"
Bad: "Fixed stuff"
```

## Review Process

1. All pull requests will be reviewed by maintainers
2. Technical contributions may be sent to domain experts for verification
3. We may request changes or clarifications before merging
4. Significant contributions will be acknowledged in the book

## Code of Conduct

- Be respectful and constructive in all interactions
- Focus on the content, not the contributor
- Assume good faith in contributions and feedback
- Keep discussions on-topic and professional

## Questions?

If you have questions about contributing that aren't answered here, please open an issue with the label "question" and we'll do our best to help.

## Thanks

We are very grateful for the support of the entire crypto community. This book exists because of the collective knowledge and open collaboration that defines this space.

Thank you for helping make this resource better for everyone.

---

**Larry Cermak, Wintermute Research, and The Block Research**

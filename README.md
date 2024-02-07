# til

Today I Learned

## create new article

create with template.

```bash
article=This-is-a-sample-article
cat << EOF > "${article}.md"
---
bibliography: 
repositoryUrl:
draft: true
---

# ${article}

EOF
```

commit the article.

```bash
git add "${article}.md"
git commit -m "add: ${article}"
```

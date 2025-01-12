const fs = require('fs');

(async () => {
    try {
        const url = process.argv[2];
        const outputPath = process.argv[3];

        // Extract titleSlug from URL
        const titleSlug = url.split('/problems/')[1].split('/')[0];

        // GraphQL query to get problem details
        const query = {
            query: `
                query questionData($titleSlug: String!) {
                    question(titleSlug: $titleSlug) {
                        title
                        content
                        difficulty
                        exampleTestcases
                    }
                }
            `,
            variables: { titleSlug }
        };

        // Fetch problem data from LeetCode API
        const response = await fetch('https://leetcode.com/graphql', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(query)
        });

        const data = await response.json();
        const problem = data.data.question;

        // Clean up the HTML content
        const cleanContent = problem.content
            .replace(/<\/?code>/g, '`')  // Replace <code> tags with backticks
            .replace(/<pre>/g, '\n```\n') // Replace <pre> with code blocks
            .replace(/<\/pre>/g, '\n```\n')
            .replace(/<[^>]*>/g, '')     // Remove other HTML tags
            .replace(/&lt;/g, '<')       // Replace HTML entities
            .replace(/&gt;/g, '>')
            .replace(/&quot;/g, '"')
            .replace(/&amp;/g, '&')
            .replace(/\n\s*\n\s*\n/g, '\n\n') // Remove extra newlines
            .trim();

        // Format the markdown
        const markdown = 
            `# ${problem.title}\n\n` +
            `## Difficulty: ${problem.difficulty}\n\n` +
            `## Problem URL\n${url}\n\n` +
            `## Task\n${cleanContent}\n\n` +
            `## Example Test Cases\n\`\`\`\n${problem.exampleTestcases}\n\`\`\`\n\n` +
            `## Solution Attempts\n\n` +
            `| Date Attempted | Time Complexity | Duration | Notes |\n` +
            `|---------------|-----------------|----------|-------|\n` +
            `| | | | |\n\n` +
            `## Current Approach\n<!-- Describe your approach to solving the problem here -->\n\n` +
            `## Current Solution\n\`\`\`python\n\n\`\`\`\n\n` +
            `## Complexity Analysis\n` +
            `- Time Complexity: \n` +
            `- Space Complexity: \n\n` +
            `## Learning Notes\n<!-- Key insights and learning points from all attempts -->\n\n` +
            `---\nTags: [[LeetCode]] [[${problem.difficulty}]]\n` +
            `Created: ${new Date().toLocaleString()}`;

        // Write to file
        fs.writeFileSync(outputPath, markdown);
        console.log(`Successfully created: ${outputPath}`);
        
    } catch (error) {
        console.error("Error:", error.message);
        process.exit(1);
    }
})(); 
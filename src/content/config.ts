import { defineCollection, z } from 'astro:content';

const projectsCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.string(),
    category: z.enum(['Suspension', 'Armor', 'Storage', 'Electrical', 'Recovery', 'Camping', 'Other']),
    difficulty: z.enum(['Beginner', 'Intermediate', 'Advanced']),
    heroImage: z.string(),
    youtubeId: z.string().optional(),
    featured: z.boolean().default(false),
    tags: z.array(z.string()).optional(),
  }),
});

export const collections = {
  'projects': projectsCollection,
};

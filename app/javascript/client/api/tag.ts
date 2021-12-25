import { requests } from './index';

const url = 'tags';

export const Tag = {
  tags: async (jwt: string) => await requests.get(url, jwt),
};
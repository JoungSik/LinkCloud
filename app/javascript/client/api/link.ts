import { requests } from './index';
import { LinkType } from '../models/link';

const url = 'links';

export const Link = {
    links: async (jwt: string) => await requests.get(url, jwt),
    createLink: async (jwt: string, link: LinkType) => await requests.post(url, link, jwt)
};
import React from 'react';
import { Badge, Box, Link } from '@chakra-ui/react';
import { ExternalLinkIcon } from '@chakra-ui/icons';
import { LinkType } from '../models/link';

interface LinkProps {
    link: LinkType
}

const LinkBox = ({ link }: LinkProps) => {
    return (
        <Box maxW="sm" borderWidth="1px" borderRadius="lg" overflow="hidden">
            <Box p="6">
                <Link href={link.url} isExternal>{link.name} <ExternalLinkIcon mx="2px" /></Link>
                <Box display="flex" alignItems="baseline" mt={3}>
                    {
                        link.tag_list.split(', ').map(tag =>
                            <Badge key={tag} borderRadius="full" px="2" colorScheme="teal" mr={2}>{tag}</Badge>)
                    }
                </Box>
            </Box>
        </Box>
    )
};

export default LinkBox;
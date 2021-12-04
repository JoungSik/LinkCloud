import React from 'react';
import { Badge, Box, Button, Link } from '@chakra-ui/react';
import { DeleteIcon, ExternalLinkIcon } from '@chakra-ui/icons';
import { LinkType } from '../models/link';

interface LinkProps {
    link: LinkType,
    onClickDeleteLink: (link: LinkType) => void,
}

const LinkBox = ({ link, onClickDeleteLink }: LinkProps) => {
    return (
        <Box minW="3xs" maxW="sm" borderWidth="1px" borderRadius="lg" overflow="hidden">
            <Box p="6">
                <Link href={link.url} isExternal>{link.name} <ExternalLinkIcon mx="2px" /></Link>
                <Box display="flex" alignItems="baseline" mt={3}>
                    {
                        link.tag_list.split(', ').map(tag =>
                            <Badge key={tag} borderRadius="full" px="2" colorScheme="teal" mr={2}>{tag}</Badge>)
                    }
                </Box>
                <Button leftIcon={<DeleteIcon />} colorScheme="teal" variant="outline" mt={3}
                        onClick={() => onClickDeleteLink(link)}>
                    삭제
                </Button>
            </Box>
        </Box>
    )
};

export default LinkBox;
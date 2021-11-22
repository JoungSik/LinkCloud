import React, { useEffect, useState } from 'react';
import { Container, Progress, Wrap } from '@chakra-ui/react';
import { useMutation, useQuery, useQueryClient } from 'react-query';
import { Link } from '../api/link';
import { LinkType } from '../models/link';
import LinkBox from '../components/link';
import NewLinkBox from '../components/new_link';
import useLocalStorage from '../utils/storage';

const Home = () => {
    const { storedValue } = useLocalStorage('user');
    const { status, data } = useQuery('links', () => Link.links(storedValue.authorization));

    const [links, setLinks] = useState<LinkType[]>([]);

    const queryClient = useQueryClient();
    const mutation =  useMutation(
        link => Link.deleteLink(storedValue.authorization, link), {
            onMutate: async (link: LinkType) => {
                await queryClient.cancelQueries('links')

                const previousTodos = queryClient.getQueryData<LinkType[]>('links')
                if (previousTodos) {
                    queryClient.setQueryData<LinkType[]>('links', previousTodos.filter(p_link => p_link.id !== link.id))
                }
                return { previousTodos }
            },
            onSettled: () => {
                queryClient.invalidateQueries('links')
            },
        }
    );

    const onDeleteLink = (link: LinkType) => mutation.mutate(link);

    useEffect(() => {
        if (data) {
            setLinks(data as LinkType[]);
        }
    }, [data]);

    if (status === 'loading') {
        return (
            <Container maxW="container.xl">
                <Progress size="xs" isIndeterminate colorScheme={'whiteAlpha'} />
            </Container>
        )
    }

    return (
        <Container maxW="container.xl">
            <Wrap spacing={4}>
                <NewLinkBox />
                {
                    links.map(link => <LinkBox key={link.id} link={link} onClickDeleteLink={onDeleteLink} />)
                }
            </Wrap>
        </Container>
    )
};

export default Home;
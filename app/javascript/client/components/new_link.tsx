import React from 'react';
import {
    Box,
    Button,
    Flex,
    FormControl,
    FormErrorMessage,
    FormLabel,
    Input,
    Modal,
    ModalBody,
    ModalCloseButton,
    ModalContent,
    ModalFooter,
    ModalHeader,
    ModalOverlay,
    useDisclosure
} from '@chakra-ui/react';
import { useMutation, useQueryClient } from 'react-query';
import { SubmitHandler, useForm } from 'react-hook-form';
import { Link } from '../api/link';
import { LinkType } from '../models/link';
import useLocalStorage from '../utils/storage';

const NewLinkBox = () => {
    const queryClient = useQueryClient();
    const { storedValue } = useLocalStorage('user');

    const { isOpen, onOpen, onClose } = useDisclosure();

    const { register, handleSubmit, formState: { errors }, reset } = useForm<LinkType>();

    const mutation = useMutation(
        link => Link.createLink(storedValue.authorization, link), {
            onMutate: async (link: LinkType) => {
                await queryClient.cancelQueries('links')

                const previousTodos = queryClient.getQueryData<LinkType[]>('links')
                if (previousTodos) {
                    queryClient.setQueryData<LinkType[]>('links', previousTodos.concat(link))
                }
                return { previousTodos }
            },
            onSuccess: () => {
                onClose();
                reset();
            },
            onError: (err, variables, context) => {
                if (context?.previousTodos) {
                    queryClient.setQueryData<LinkType[]>('links', context.previousTodos)
                }
            },
            onSettled: () => {
                queryClient.invalidateQueries('links')
            },
        }
    );

    const onSubmit: SubmitHandler<LinkType> = data => mutation.mutate(data);

    return (
        <>
            <Box minW="3xs" maxW="sm" borderWidth="1px" borderRadius="lg" overflow="hidden"
                 display={'flex'} alignItems={'center'} justifyContent={'center'} p={6}>
                <Button colorScheme="teal" size="lg" onClick={onOpen}>링크 추가</Button>
            </Box>

            <Modal isOpen={isOpen} onClose={onClose}>
                <ModalOverlay />
                <ModalContent as={'form'} onSubmit={handleSubmit(onSubmit)}>
                    <ModalHeader>링크 추가</ModalHeader>
                    <ModalCloseButton />
                    <ModalBody>
                        <FormControl id="name" isInvalid={errors.name?.type === 'required'}>
                            <FormLabel>이름</FormLabel>
                            <Input placeholder="이름" {...register('name', { required: true })} />
                            <FormErrorMessage>{errors.name && '이름을 입력해주세요.'}</FormErrorMessage>
                        </FormControl>
                        <FormControl id="url" mt={2} isInvalid={errors.url?.type === 'required'}>
                            <FormLabel>주소</FormLabel>
                            <Input placeholder="URL" {...register('url', { required: true })} />
                            <FormErrorMessage>{errors.url && '주소를 입력해주세요.'}</FormErrorMessage>
                        </FormControl>
                        {/*<FormControl id="tag_list" mt={2}>*/}
                        {/*    <FormLabel>태그</FormLabel>*/}
                        {/*    <Input placeholder="Frontend, Backend" {...register('tag_list')} />*/}
                        {/*</FormControl>*/}
                    </ModalBody>
                    <ModalFooter>
                        <Button variant="ghost" mr={3} onClick={onClose}>취소</Button>
                        <Button type={'submit'} colorScheme="blue">저장</Button>
                    </ModalFooter>
                </ModalContent>
            </Modal>
        </>
    )
};

export default NewLinkBox;
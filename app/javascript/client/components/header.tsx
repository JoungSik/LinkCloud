// https://chakra-templates.dev/navigation/navbar
import React from 'react';
import {
    Box,
    Button,
    Flex,
    IconButton,
    Stack,
    Text,
    useBreakpointValue,
    useColorModeValue,
    useDisclosure
} from '@chakra-ui/react';
import { CloseIcon, HamburgerIcon } from '@chakra-ui/icons';
import { useHistory } from 'react-router-dom';
import useLocalStorage from '../utils/storage';
import { User } from "../api";

const Header = () => {
    const history = useHistory();

    const {storedValue, setStoredValue} = useLocalStorage('user');
    const {isOpen, onToggle} = useDisclosure();

    const logout = () => User.logout().then(() => setStoredValue(null));

    return (
        <Box as={'header'} position={'sticky'} top={0}>
            <Flex minH={'60px'} py={{base: 2}} px={{base: 4}}
                  bg={useColorModeValue('white', 'gray.800')} color={useColorModeValue('gray.600', 'white')}
                  borderBottom={1} borderStyle={'solid'} borderColor={useColorModeValue('gray.200', 'gray.900')}
                  align={'center'}>
                <Flex flex={{base: 1, md: 'auto'}} ml={{base: -2}} display={{base: 'flex', md: 'none'}}>
                    <IconButton onClick={onToggle} variant={'ghost'} aria-label={'Toggle Navigation'}
                                icon={
                                    isOpen ? <CloseIcon w={3} h={3} /> : <HamburgerIcon w={5} h={5} />
                                } />
                </Flex>
                <Flex flex={{base: 1}} justify={{base: 'center', md: 'start'}}>
                    <Text fontFamily={'heading'}
                          textAlign={useBreakpointValue({base: 'center', md: 'left'})}
                          color={useColorModeValue('gray.800', 'white')}>
                        Link Cloud
                    </Text>
                </Flex>

                <Stack flex={{base: 1, md: 0}} justify={'flex-end'} direction={'row'} spacing={6}>
                    {
                        storedValue ?
                            <Button as={'a'} fontSize={'sm'} fontWeight={400} variant={'link'}
                                    onClick={logout}>로그아웃</Button> :
                            <Button as={'a'} fontSize={'sm'} fontWeight={400} variant={'link'}
                                    onClick={() => history.push('/login')}>로그인</Button>
                    }
                </Stack>
            </Flex>
        </Box>
    )
};

export default Header;